function [estAng]  = estimateAttitude(thetaAng,targetVec,cameraVec)
% Estimate the current position based on sensed range data
% 
% Inputs: thetAng            theta angle from image sensor 1x1
%         targetVec          vector from target in ECEF frame nx3     
%         cameraVec          vector from camera in Body frame 1x3
%
% Output: estAng             attitude estimate 1x1
%
% Assumptions and Limitations:
%    
%
% Dependencies:
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Ju1 16 2019 - Initial version
%


% Get angle between target and ECEF x axis
targetAngle = acos(dot(targetVec,[1 0 0]));

% Get the angle between camera and Body x axis
cameraAngle = acos(dot(cameraVec,[1 0 0]));

% The platform attitude angle is the sum of the target angle 
% and the angle to the camera

estAng = targetAngle + cameraAngle;