
function [outputForce,outputMoment,thrusterOn,thrusterOnTimes,optCOG] = thrusterModel2(time,controlForce,controlMoment,thrusterData)

% Function to model a set of thrusters
% 
% Inputs: time             current time (s)
%         cmdForce         force command signal (N)
%         cmdMoment        moment command signal (N-m)
%
% Output: outputForce      force produced by thrusters (N)
%         outputMoment     moment produced by wheel (N-m)
%         thrusterOnTimes  array of thruster on-times (s)
%
% Assumptions and Limitations:
%     Thrust is modeled as a square wave
%
% References:
%
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

    persistent prevTime

    if isempty(prevTime)
        deltaT = 0;
        prevTime = 0;
    else
        deltaT = time - prevTime;
    end

    % Thruster Data
%    nThruster     = thrusterData.nThruster;
    nThruster = 8;
    minOnTime = thrusterData.minOnTime;   % ms
    timeStep = 0.025;
    
    % Zero the ontimes for this time step
    ontime = zeros(3);
    ontimes = zeros(nThruster,1);

    
    minImpulse = minOnTime*thrusterData.nominalThrust;
  
%     cmdFM =[controlForce controlMoment];
    cmdFM =[controlForce(1:2) controlMoment(3)];
    cmdImpulse = cmdFM*timeStep;
    cog = thrusterData.cog;
    ulambda = thrusterData.ulambda;
    FM = thrusterData.FM;
    AjInv = thrusterData.AjInv;
    
    ncog = size(cog,1);
    maxVal = 0;
    optCOG = 1;
    tbtime = NaN*ones(ncog,1);
    btime = zeros(ncog,3);
    % Find the optimal COG for this command
    for i = 1:ncog
%         dotResult = dot(ulambda(i,:),cmdFM);
%         if dotResult > maxVal
%             optCOG = i;
%             maxVal = dotResult;
%         end
        Ajinv = squeeze(AjInv(i,:,:));
        btime(i,:) = Ajinv*cmdImpulse';
        xx=sum(btime(i,:) >= 0);
        if xx == 3
            % All positive or zero burn times
            tbtime(i) = sum(btime(i,:));
        end
    end
    [val optCOG] = min(tbtime);
    ontimes(cog(optCOG,:)) = btime(optCOG,:);
    
    % Zero on-times below the min impulse
    thrusterOn = ontimes > minOnTime;
    thrusterOnTimes = thrusterOn.*ontimes;
    thrusterOnTimes = thrusterOn.*minOnTime;
    FM1 = thrusterOn(cog(optCOG,1))*FM(cog(optCOG,1),:);
    FM2 = thrusterOn(cog(optCOG,2))*FM(cog(optCOG,2),:);
    FM3 = thrusterOn(cog(optCOG,3))*FM(cog(optCOG,3),:);
    
    
%     c12 = cross(FM1,FM2);
%     c13 = cross(FM1,FM3);
%     c23 = cross(FM2,FM3);
%     s = dot(FM3,c12);
%     ontime(3) = dot(cmdFM,c12);
%     ontime(3) = abs(ontime(3)/s);
%     ontime(2) = dot(cmdFM,c13);
%     ontime(2) = abs(ontime(2)/s);
%     ontime(1) = dot(cmdFM,c23);
%     ontime(1) = abs(ontime(1)/s);
%     
%     ontimes(cog(optCOG,1)) = ontime(1);
%     ontimes(cog(optCOG,2)) = ontime(2);
%     ontimes(cog(optCOG,3)) = ontime(3);
    
    

    
   
    
    % pulseWidth needs to be a persistent variable
    pulseWidth = zeros(nThruster);   
    for i = 1:nThruster
        if thrusterOn(i)
            pulseWidth(i) = pulseWidth(i) + timeStep;
        else
            pulseWidth(i) = 0.0;
        end
    end
    
    totalFM = FM1 + FM2 + FM3;
    outputForce  = [totalFM(1:2) 0]';
    outputMoment = [0 0 totalFM(3)]';
 