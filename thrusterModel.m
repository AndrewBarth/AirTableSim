
function [outputForce,outputMoment,thrusterOn,thrusterOnTimes] = thrusterModel(time,controlForce,controlMoment,thrusterData)

% Function to model a set of thrusters
% 
% Inputs: time             current time (s)
%         cmdForce         force command signal (N)
%         cmdMoment        moment command signal (N-m)
%
% Output: outputForce      force produced by thrusters (N)
%         outputMoment     moment produced by wheel (N-m)
%         thrusterOn       thruster on/off commands
%         thrusterOnTimes  array of thruster on-times (s)
%
% Assumptions and Limitations:
%     Thrust is modeled as a square wave
%
% Dependencies:
%
% References:
%   Thruster Layout
%     1       3   
%    2         4
%
%
%    5         7
%     6       8
% 
% Author: Andrew Barth
%
% Modification History:
%    Jan 14 2019 - Initial version
%    Apr 10 2019 - Moved thruster definition to separate file

    persistent prevTime

    if isempty(prevTime)
        deltaT = 0;
        prevTime = 0;
    else
        deltaT = time - prevTime;
    end

    outputForce  = [0 0 0]';
    outputMoment = [0 0 0]';
    
    % Thruster Data
%     nThruster     = thrusterData.nThruster;
    nThruster = 8;
    minOnTime     = 0.05;   % s
    timeStep = 0.025;
    
    % Zero the output for this time step
    outputForce  = [0 0 0]';
    outputMoment = [0 0 0]';
    thrusterOnTimes = zeros(nThruster,1);
    
    minImpulse = minOnTime*thrusterData.nominalThrust;
  
    cmdFM =[controlForce controlMoment];
     
    C = thrusterData.thrusterCombinations;
    
    % Compute the Force/Moment vectors and unit vectors for all
    % combinations of thrusters
    F     = zeros(size(C,1),3);
    M     = zeros(size(C,1),3);
    unitF = zeros(size(C,1),3);
    unitM = zeros(size(C,1),3);
    for i = 1:size(C,1)
        for j = 1:3
            if C(i,j) ~= 0
                F(i,:) = F(i,:) + thrusterData.thrusterForce(C(i,j),:);
                M(i,:) = M(i,:) + thrusterData.thrusterMoment(C(i,j),:);
            end
        end
        if norm(F(i,:)) < eps
            unitF(i,:) = [0 0 0];
        else
            unitF(i,:) = F(i,:) / norm(F(i,:));
        end
        if norm(M(i,:)) < eps
            unitM(i,:) = [0 0 0];
        else
            unitM(i,:) = M(i,:) / norm(M(i,:));
        end
    end
   
    % Set the command vector
    unitCmd = zeros(1,6);
    if norm(cmdFM) > eps
        unitCmd = cmdFM / norm(cmdFM);
    end
    
    % Determine which thruster combination is closest to the command
    dist = zeros(size(unitF,1),1);
    for i = 1:size(unitF,1)
        dist(i) = norm(unitCmd - [unitF(i,:) unitM(i,:)]);
    end
    [delt idx] = min(dist);
    
    % The impulse for the current time step
%     Fimpulse = F(idx,:)*timeStep;
%     Mimpulse = M(idx,:)*timeStep;
    Fimpulse = F(idx,:)*minOnTime;
    Mimpulse = M(idx,:)*minOnTime;
    cmdFimpulse = cmdFM(1:3)*timeStep;
    cmdMimpulse = cmdFM(4:6)*timeStep;
    %ontimes = 
    if norm(cmdFimpulse) >= norm(Fimpulse) || norm(cmdMimpulse) >= norm(Mimpulse)
        outputForce  = F(idx,:)';
        outputMoment = M(idx,:)';
        for i=1:3
            if C(idx,i) ~= 0
                thrusterOnTimes(C(idx,i)) = timeStep;
            end
        end
    end

    % Compute the thruster command
    thrusterOn = thrusterOnTimes > eps;
    
    % pulseWidth needs to be a persistent variable
    pulseWidth = zeros(nThruster);   
    for i = 1:nThruster
        if thrusterOn
            pulseWidth(i) = pulseWidth(i) + timeStep;
        else
            pulseWidth(i) = 0.0;
        end
    end
    

