function [ControlSignal] = planarPIDControl(t,y,kp,kd,ki,refTraj)

% Function to generate a control signal based on a PID controller
% The state vector consists of 3 - 3x1 vectors. [q qdot integral of q]
% This function is designed so that it can be called from within the 
% integration routine (at a single time point) or after the integration 
% (with a vector of all time points)
% 
% Inputs: t       current time step
%         y       state vector (q qdot integral q) 9x1  
%         kp      proportional gain 1x3
%         kd      derivative gain 1x3
%         ki      integral gain 1x3
%         refTraj reference trajectory
%
% Output: ControlSignal control signal to be output to the effectors
%
% Assumptions and Limitations:
%    none
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Dec 20 2018 - Initial version
%

    % Parse state vector. 
    qdot = y(1:3,:);   % [Vx Vy wz]'
    q    = y(4:6,:);   % [x y theta]'
    intq = y(7:9,:);   % [integral(x) integral(y) integral(theta)]'
    
    % Form gain matrices
    Kp = [kp(1) 0 0; 0 kp(2) 0; 0 0 kp(3)];
    Kd = [kd(1) 0 0; 0 kd(2) 0; 0 0 kd(3)];
    Ki = [ki(1) 0 0; 0 ki(2) 0; 0 0 ki(3)];
    
    % Get the reference values
    for i=1:max(size(t))
        % Can't figure out how to get interp function to hold last value
        % for an array of inputs so have to do it 1 at a time for now
        qRef(1,i) = interp1(refTraj(:,1),refTraj(:,2),t(i),'linear',refTraj(end,2))';
        qRef(2,i) = interp1(refTraj(:,1),refTraj(:,3),t(i),'linear',refTraj(end,3))';
        qRef(3,i) = interp1(refTraj(:,1),refTraj(:,4),t(i),'linear',refTraj(end,4))';
        qdotRef(1,i) = interp1(refTraj(:,1),refTraj(:,5),t(i),'linear',refTraj(end,5))';
        qdotRef(2,i) = interp1(refTraj(:,1),refTraj(:,6),t(i),'linear',refTraj(end,6))';
        qdotRef(3,i) = interp1(refTraj(:,1),refTraj(:,7),t(i),'linear',refTraj(end,7))';
        qRef_t(1,i) = qRef(1,i) .* t(i);
        qRef_t(2,i) = qRef(2,i) .* t(i);
        qRef_t(3,i) = qRef(3,i) .* t(i);
    end
    
    % Form control signal
    ControlSignal = Kp*q + Kd*qdot + Ki*intq - Kp*qRef - Kd*qdotRef - Ki*qRef_t;
 
end