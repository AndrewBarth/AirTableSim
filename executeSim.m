function [cost] = executeSim(x,controlType)
% This function is intended to run within a call to the ga function
% 
% Inputs: x           the array of values for the MF scale factors. x is
%                     an individual in the ga 1x56
%         maxSpeed    maximum value for speed MF
%         maxRoom     maximum size of the room
%         maxGoal     maximum distance you could be from the goal
%         moBotData   structure with robot, rod, and room info
%         controlFlag indicates type of control requested
%         ICidx       IC case to run
%
% Output: cost        cost value for each set of runs
%
% Assumptions and Limitations:
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Apr 20 2019 - Initial version
%    May  6 2019 - Reduced number of membership functions 
%    May  9 2019 - Run a set of ICs on each pass through this function
%

cost = 0;

% Load general data file
loadBusData();
assignin('base','FullStateBus',FullStateBus);
assignin('base','ControlOutBus',ControlOutBus);

% Load the Simulink model and put the Gains in the model's workspace
load_system('Top6DOFModel');
modelWS = get_param('Top6DOFModel', 'modelworkspace');

% Assign the inputs 
if controlType == 1
    SMGains = x;
    assignin(modelWS,'SMGains',SMGains);
else
    Kp = [x(1) x(2) 0 0 0 x(3)];
    Kd = [x(4) x(5) 0 0 0 x(6)];
    Ki = [x(7) x(8) 0 0 0 x(9)];
    assignin(modelWS,'Kp',Kp);
    assignin(modelWS,'Kd',Kd);
    assignin(modelWS,'Ki',Ki);
end
x

% Run the simulation
sim('Top6DOFModel')
clear(modelWS);
close_system('Top6DOFModel',0);

% Collect thruster Data
for i=1:size(thrusterOnTimes.Data,2)
    tOntime(1,i) = 0;
    nPulse(i) = 0;
    for j=2:size(thrusterOnTimes.Data,1)
        tOntime(j,i) = tOntime(j-1,i) + thrusterOnTimes.Data(j,i);
        if thrusterOnTimes.Data(j,i) > eps && thrusterOnTimes.Data(j-1,i) < eps
            nPulse(i) = nPulse(i) + 1;
        end
    end
end
totalPulses = sum(nPulse);
cost = totalPulses;

% Check Final State
% THIS STOPS BEFORE APPROACH CONTROL
refPos = squeeze(refTraj.Data(5,2:4,end));
% refPos = [1.5 2.75 0];
refAng = squeeze(refTraj.Data(5,5:7,end));
refVel = squeeze(refTraj.Data(5,8:10,end));
refRate = squeeze(refTraj.Data(5,11:13,end));
ECEFpos = stateOutBus.TranState_ECEF.R_Sys_ECEF.Data(end,:);
ECEFvel = stateOutBus.TranState_ECEF.V_Sys_ECEF.Data(end,:);
EulerAngles = stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler.Data(end,:);
BodyRates = stateOutBus.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Data(end,:);
posError = ECEFpos - refPos;
angError = EulerAngles - refAng;
velError = ECEFvel - refVel;
rateError = BodyRates - refRate;
cost = cost + norm([posError(1) posError(2)])*1000;
cost = cost + abs(angError(3))*1000;
if abs(posError(1)) > 0.03 || abs(posError(2)) > 0.03
    cost = cost + 1000;
end
if abs(angError(3)) > .01*pi/180
    cost = cost + 1000;
end
cost