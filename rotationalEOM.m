function [dy] = rotationalEOM(t,y,Mext,Meff,Inertia)
% Rotational equations of motion for a rigid body
% The state vector consists of 2 vectors [q qdot]
% This function is designed to be used with the ode45 function
%
% Inputs: t       current time step
%         y       state vector (q qdot) 6x1  
%         Mext    external moments 3x1
%         Meff    effector moments 3x1
%         Inertia inertia values 3x1
%
% Output: dy  derivative for state array 7x1
%
% Assumptions and Limitations:
%    Calculations performed about body-fixed principal axes
%
% Dependencies:
%
% References:
%    Wie, Bong. Space vehicle dynamics and control. 
%    American Institute of Aeronautics and Astronautics, 2008.
%
%    Euler equations of motion
%    M = I*wDot + w X Iw
%    Mx = I1*wxDot + (I3-I2)*wy*wz
%    My = I2*wyDot + (I1-I3)*wz*wx
%    Mz = I3*wzDot + (I2-I1)*wx*wy
%
% Author: Andrew Barth
%
% Modification History:
%    May 14 2019 - Initial version
%    May 23 2019 - Switched to quaternion integration
%

% Parse state vector. 
q    = y(1:3);   % [phi theta psi]
qdot = y(4:6);   % [wx wy wz]

% Inertia Matrix
J = [Inertia(1) 0 0; 0 Inertia(2) 0; 0 0 Inertia(3)];
if Inertia(1) < eps && Inertia(2) < eps
    Jinv = [0 0 0; 0 0 0; 0 0 1/Inertia(3)];
else
    Jinv = J\eye(size(J));
end

% Net moment
Mnet = Mext + Meff;

% Get attitude quaternion
quat = euler2quat(q);
qs = quat(1);
qv = quat(2:4);

% Compute the quaternion derivative
qsDot = -0.5*qdot'*qv';
qvDot = 0.5*(qs*qdot' - cross(qdot,qv));
quatDot = [qsDot qvDot];

% Angular velocity terms
C1 = Inertia.*qdot;
C2 = cross(qdot,C1);

% A = [ zeros(3,3) eye(3,3); zeros(3,3) zeros(3,3)];
% B = [zeros(3,1); Jinv*(Mnet - C2)];
% D = A*[q; qdot]
% dy = [quatDot'; B(4:6)+D(4:6)];

B = [Jinv*(Mnet - C2)];
dy = [quatDot'; B];
    
