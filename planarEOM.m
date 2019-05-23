function [dxdy] = planarEOM(t,y,FMext,FMeff,m,Izz)
% Equations of motion for a rigid body constrained to planar motion
% The state vector consists of 3 - 3x1 vectors. [q qdot integral of q]
% This function is designed to be used with the ode45 function
%
% Inputs: t       current time step
%         y       state vector (q qdot integral q) 9x1  
%         FMext   external forces and moment 1x3
%         FMeff   effector forces moments 1x3
%         m       mass
%         Izz     moment of inertia 
%
% Output: dxdy  derivative for state array 9x1
%
% Assumptions and Limitations:
%    None
%
% Dependencies:
%
% References:
% Newton and Euler equations of motion
% Fx = m*(vdotx - wz*vy)
% Fy = m*(vdoty + wz*vx)
% Mz = Izz*wdotz
%
% Author: Andrew Barth
%
% Modification History:
%    Dec 20 2018 - Initial version
%    May 13 2019 - Reordered state vector
%

    % Parse state vector. 
    q    = y(1:3)';   % [x y theta]
    qdot = y(4:6)';   % [Vx Vy wz]
    intq = y(7:9)';   % [integral(x) integral(y) integral(theta)]
       
    % Mass Matrix
    M = [m 0 0; 0 m 0; 0 0 Izz];
    Minv = M\eye(size(M));

    % Force/Moment terms
    FM = Minv*(FMext + FMeff);
    
    % Centripetal/Coriolis terms
    CC = [qdot(3)*qdot(2); -qdot(3)*qdot(1); 0];
      
    B = [zeros(3,1); (FM - CC); zeros(3,1)];
    A = [ zeros(3,3) eye(3,3) zeros(3,3); zeros(3,3) zeros(3,3) zeros(3,3); eye(3,3) zeros(3,3) zeros(3,3)];
    C = A*[q'; qdot'; intq'];
    
    dxdy = B + C;


    
