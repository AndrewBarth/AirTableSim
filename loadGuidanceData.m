
dtr = pi/180;


%% Range Guidance

% Set if range guidance is to be use after the final point in the reference
% trajectory has been reached
useRangeGuid = 0;

% Parameters for the range guidance
rangeSensorIdx = 1;          % this value represents the range sensor that will be facing the target
finalRangeValue = 0.25;      % m
finalRangeAttitude = [0 0 90]*dtr;    % Euler angles for vehicle attitude during range guidance

