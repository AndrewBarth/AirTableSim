
function [outputForce,outputMoment,thrusterOn,thrusterOnTimes,onPulseWidth] = thrusterModel(time,controlForce,controlMoment,thrusterData,prev_onPulseWidth)

% Function to model a set of thrusters
% 
% Inputs: time             current time (s)
%         cmdForce         force command signal (N)
%         cmdMoment        moment command signal (N-m)
%         thrusterData     thruster data structure
%         prev_onPulseWidth on pulse width for each thruster (s)
%
% Output: outputForce      force produced by thrusters (N)
%         outputMoment     moment produced by wheel (N-m)
%         thrusterOn       thruster on/off commands
%         thrusterOnTimes  array of thruster on-times (s)
%         onPulseWidth     on pulse width for each thruster (s)
%
% Assumptions and Limitations:
%     Thrust is modeled as a square wave
%
% Dependencies:
%
% References:
%   Thruster Layout
%     3       2   
%    4         1
%
%
%    5         8
%     6       7
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
    nThruster     = 8;
%     timeStep = 0.025;
    timeStep = 0.025;
    
    % Zero the output for this time step
    outputForce  = [0 0 0]';
    outputMoment = [0 0 0]';
    thrusterOnTimes = zeros(nThruster,1);
    thrusterOn = zeros(nThruster,1);
    
    cmdFM =[controlForce controlMoment];
    cmdImpulse = cmdFM*timeStep;
    
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
    Fimpulse = F(idx,:)*thrusterData.minOnTime;
    Mimpulse = M(idx,:)*thrusterData.minOnTime;
    cmdFimpulse = cmdFM(1:3)*timeStep;
    cmdMimpulse = cmdFM(4:6)*timeStep;
   
    if norm(cmdFimpulse) >= norm(Fimpulse) || norm(cmdMimpulse) >= norm(Mimpulse)
%         outputForce  = F(idx,:)';
%         outputMoment = M(idx,:)';
        for i=1:3
            if C(idx,i) ~= 0
                thrusterOnTimes(C(idx,i)) = timeStep;
            end
        end
    end

    % Compute the thruster command
    thrusterOn = thrusterOnTimes > eps;
    
    % pulseWidth needs to be a persistent variable
    onPulseWidth = prev_onPulseWidth;   
    for i = 1:nThruster
        if thrusterOn(i)
            outputForce  = outputForce + thrusterData.thrusterForce(i,:)';
            outputMoment = outputMoment + thrusterData.thrusterMoment(i,:)';
%             onPulseWidth(i) = onPulseWidth(i) + timeStep;
%         else
%             if onPulseWidth(i) > eps && onPulseWidth(i) < (thrusterData.minOnTime-eps)
%                 % Hold the thruster on for anohter cycle
%                 onPulseWidth(i) = onPulseWidth(i) + timeStep;
%                 outputForce  = outputForce + thrusterData.thrusterForce(i,:)';
%                 outputMoment = outputMoment + thrusterData.thrusterMoment(i,:)';
%                 thrusterOnTimes(i) = timeStep;
%                 thrusterOn(i) = uint8(1);
%             else
%                 onPulseWidth(i) = 0.0;
%             end
        end
    end

  

