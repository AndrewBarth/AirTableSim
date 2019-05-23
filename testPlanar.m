rtd = 180/pi;
dtr = pi/180;

clear reactionWheel
clear planarPIDControl



[m Izz] = planarMassProperties();

% kp = [2000 2000 55];
% kd = [400 400 8.7];
% ki = [80 500 100];

 kp = [2000 2000 55];
 kd = [400 400 9];
 ki = [0 0 0];

% Reference trajectory
% refq = [1 2 45*dtr];
refq = [1 0 45*dtr];
refqdot = [0 0 0];
refTime = [0 3]';
refTraj = [ refTime [zeros(size(refq,2),1)'; refq] [zeros(size(refqdot,2),1)'; refqdot] ]; 
%refTraj = [ refTime [refq; refq] [refqdot; refqdot] ]; 
% Initial state. 
qdot = [0 0 0];
q = [0 0 0];
intq = [0 0 0];

clear yy dxdy wheelRate Mc timeVec

Fext = [0 0 0];
Mext = [0 0 0];

Tint = 0.025;
Tfinal = 10;
timeVec = 0:Tint:Tfinal;
npts = size(timeVec,2);

% Pre-allocate vector sizes
dxdy = zeros(npts,9);
y = zeros(npts,9);
wheelRate = zeros(npts,1);
Mc = zeros(npts,3);

y(1,:) = [qdot q intq];
for i = 2:npts
     %[t,y]=ode45(@(t,y) planarDynamics(t,y,kp,kd,ki,Fext,Mext,Fcont,Mcont,m,Izz,refTraj),[0 10],[qdot'; q'; intq']);
     [dxdy(i,:) wheelRate(i,:) Mc(i,:)] = planarDynamics(timeVec(i),y(i-1,:)',kp,kd,ki,Fext,Mext,m,Izz,refTraj);
     y(i,:) = y(i-1,:) + dxdy(i,:)*Tint;
    % Compute ECEF to body axis transformation
    M_Body_To_ECEF = [cos(y(i,6)) -sin(y(i,6)) 0; sin(y(i,6)) cos(y(i,6)) 0; 0 0 1];
    M_ECEF_To_Body = M_Body_To_ECEF';
    stateVec(i,:) = M_Body_To_ECEF*y(i,4:6)';
end
 t = timeVec;
% Mc = -1*planarPIDControl(timeVec',y',kp,kd,ki,refTraj);