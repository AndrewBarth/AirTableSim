    
function [dxdy, wheelRate, FMcontrol_B] = planarDynamics(t,y,kp,kd,ki,Fext_ECEF,Mext_ECEF,m,Izz,refTraj)
% GNC and dynamics algorithms for a rigid body constrained to planar motion
% The state vector consists of 3 - 3x1 vectors. [q qdot integral of q]
% This function is designed to be used with the ode45 function
%
% Inputs: t       current time step
%         y       state vector (q qdot integral q) 9x1  
%         kp      proportional gain 1x3
%         kd      derivative gain 1x3
%         ki      integral gain 1x3
%         Fext    external forces 1x3 ECEF frame
%         Mext    external moments 1x3 ECEF frame
%         m       mass
%         Izz     moment of inertia (about principal axis)
%         refTraj reference trajectory
%
% Output: dxdy  derivative for state array 9x1
%
% Assumptions and Limitations:
%    None
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Jan 2  2019 - Initial version
%

    % Parse state vector. 
    qdot = y(1:3)';   % [Vx Vy wz]
    q    = y(4:6)';   % [x y theta]
    intq = y(7:9)';   % [integral(x) integral(y) integral(theta)]
    
    % Compute ECEF to body axis transformation
    M_Body_To_ECEF = [cos(q(3)) -sin(q(3)) 0; sin(q(3)) cos(q(3)) 0; 0 0 1];
    M_ECEF_To_Body = M_Body_To_ECEF';
    
    R_ECEF_To_Body = [q(1) q(2) 0];
    
    % External Forces/Moments
    FMext_ECEF = [Fext_ECEF(1); Fext_ECEF(2); Mext_ECEF(3)];
    FMext_B = M_ECEF_To_Body*FMext_ECEF;
    
    % Controller
    FMcontrol_B = planarPIDControl(t,y,kp,kd,ki,refTraj);
    
    % Reaction Wheel Model
    [Mwheel wheelRate] = reactionWheel(t,FMcontrol_B(3),0.000625);
    FMeff_B = [FMcontrol_B(1); FMcontrol_B(2); Mwheel];
 
    % Evaluate the equations of motion
    dxdy = planarEOM(t,y,FMext_B,FMeff_B,m,Izz);
    
   % [t y(6)]