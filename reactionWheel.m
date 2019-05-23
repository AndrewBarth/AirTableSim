function [wheelMoment,outputWheelRate] = reactionWheel(t,cmdMoment,wheelInertia)

% Function to model a reaction wheel
% 
% Inputs: t             time
%         cmdMoment     moment command signal (N-m)
%         wheelInertia  inertia of reaction wheel (kg-m^2)
%
% Output: wheelMoment   moment produced by wheel (N-m)
%         wheelRate  wheel rate after acceleration applied (rad/s)
%
% Assumptions and Limitations:
%    wheel rate sensor errors are not yet modeled
%    actual wheel dynamics are not yet modeled
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Dec 23 2018 - Initial version
%    Dec 30 2018 - Added wheel rate computation
%

     persistent prevTime 
     persistent wheelRate
     
     if isempty(prevTime)
         deltaT = 0;
         prevTime = 0;
         wheelRate = 0;
     else
         deltaT = t - prevTime;
     end
    
     % Get the sensed wheel rate
     sensedWheelRate = wheelRate;
     
     % Compute the angular acceleration necessary produce the commanded moment
     cmdAccel = cmdMoment / wheelInertia;

     wheelRate = sensedWheelRate + cmdAccel*deltaT;

     wheelMoment = cmdMoment;

     prevTime = t;
     outputWheelRate = wheelRate;
end


