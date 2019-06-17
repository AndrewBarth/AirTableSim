
dtr = pi/180;

%% Platform Data
platformWidth  = 18*0.0254;
platformLength = 18*0.0254;

%% IMU Data
Euler_IMU_To_Body = [0 0 0];
M_IMU_To_Body = euler2mat(Euler_IMU_To_Body);
Q_IMU_To_Body = mat2quat(M_IMU_To_Body);

%% Range Sensors
% Center point of sensor
rangeSensorLocBody(1,:) = [0.5*platformWidth 0 0];
rangeSensorLocBody(2,:) = [0 0.5*platformLength 0];
rangeSensorLocBody(3,:) = [-0.5*platformWidth 0 0];
rangeSensorLocBody(4,:) = [0 -0.5*platformLength 0];

% Angle and field of view
rangeSensorAngBody = [0; 90*dtr; 180*dtr; 270*dtr];
rangeSensorFOV = [15*dtr; 15*dtr; 15*dtr; 15*dtr];

for i=1:4
    rangeSensorAngMinBody(i) = rangeSensorAngBody(i)-0.5*rangeSensorFOV(i);
    rangeSensorAngMaxBody(i) = rangeSensorAngBody(i)+0.5*rangeSensorFOV(i);
end

%% Wall Locations
wallA = [0 0 0 3];
wallB = [0 3 4 3];
wallC = [4 0 4 3];
wallD = [0 0 4 0];
wallBounds = [wallA; wallB; wallC; wallD];

wallVec    = [(wallA(3:4)-wallA(1:2))/norm(wallA(3:4)-wallA(1:2)); ...
              (wallB(3:4)-wallB(1:2))/norm(wallB(3:4)-wallB(1:2)); ...
              (wallC(3:4)-wallC(1:2))/norm(wallC(3:4)-wallC(1:2)); ...
              (wallD(3:4)-wallD(1:2))/norm(wallD(3:4)-wallD(1:2))];
clear wallA wallB wallC wallD