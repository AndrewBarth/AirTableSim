function [outControlMode] = gncExecutive(navState,refTraj,inControlMode)
% Determine when the proper location and orientation has been reached
% and proceed with the approach
% 
% Inputs: navState        current state data
%         refTraj         reference trajectory 
%         inControlMode   current control mode
%
% Output: outControlMode  desired control mode
%
% Assumptions and Limitations:
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Jun 19 2019 - Initial version

zeroPos = 0.03;
zeroVel = 0.04;
zeroAtt = 0.075;  % 1 deg
zeroRate = 0.075; % 1 deg/s

pos = navState.TranState_ECEF.R_Sys_ECEF';
vel = navState.TranState_ECEF.V_Sys_ECEF';
att = navState.RotState_Body_ECEF.ECEF_To_Body_Euler';
rate = navState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body';

refPos  = refTraj(end,2:4);
refVel  = refTraj(end,8:10);
refAtt  = refTraj(end,5:7);
refRate = refTraj(end,11:13);

posErr = norm(refPos - pos);
velErr = norm(refVel - vel);
attErr = norm(refAtt - att);
rateErr = norm(refRate - rate);

if posErr < zeroPos && velErr < zeroVel && attErr < zeroAtt && rateErr < zeroRate
    outControlMode = 2;
%     outControlMode = inControlMode;
else
    outControlMode = inControlMode;
end
