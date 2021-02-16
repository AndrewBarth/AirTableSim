function [dy] = translationalEOM(t,y,Fext,Feff,Mass,angularRates)
% Translational equations of motion for a rigid body
% The state vector consists of 2 - 3x1 vectors. [q qdot]
% This function is designed to be used with the ode45 function
%
% Inputs: t            current time step
%         y            state vector (q qdot) 6x1
%         angularRates angular rate vector 3x1
%         Fext         external forces 3x1
%         Feff         effector forces 3x1
%         Mass         mass value 1x1
%
% Output: dy  derivative for state array 6x1
%
% Assumptions and Limitations:
%
% Dependencies:
%
% References:
%    Wie, Bong. Space vehicle dynamics and control. 
%    American Institute of Aeronautics and Astronautics, 2008.
%
%    Newton equations of motion
%    F = m*(vdot + w X v)
%    Fx = m*(vdotx + wy*vz - wz*vy)
%    Fy = m*(vdoty + wz*vx - wx*vz)
%    Fz = m*(vdotz + wx*vy - wy*vx)
%
% Author: Andrew Barth
%
% Modification History:
%    May 14 2019 - Initial version
%

% Parse state vector. 
q    = y(1:3);   % [x y z]
qdot = y(4:6);   % [Vx Vy Vz]

% Mass Matrix
M = [Mass 0 0; 0 Mass 0; 0 0 Mass];
Minv = M\eye(size(M));

% Net Force
Fnet = Fext + Feff;

% Angular velocity terms
C = cross(angularRates,qdot);

A = [ zeros(3,3) eye(3,3); zeros(3,3) zeros(3,3)];
% B = [zeros(3,1); (Minv*Fnet - C)];
B = [zeros(3,1); (Minv*Fnet)];
D = A*[q; qdot];

dy = B + D;



    
