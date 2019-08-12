
dtr = pi/180;

%% Filter Coefficients
AccelIIR_Num = [0.020083365564211   0.040166731128423   0.020083365564211];
AccelIIR_Den = [1.000000000000000  -1.561018075800718   0.641351538057563];

%% Platform Data
platformWidth  = 18*0.0254;
platformLength = 18*0.0254;

%% Image Sensor Data
rangeTable = [2500 5000];
cameraVec = [1 0 0];
cameraLoc = [0.5*platformWidth 0];

%% Target locations
targetLoc(1,:) = [1 3];
targetVec(1,:) = [0 -1 0];

%% Tracking camera Data
M_Tracker_To_Body = [1 0 0; 0 1 0; 0 0 1];
R_Tracker_To_ECEF = [2 0.5 0];

%% IMU Data
Euler_IMU_To_Body = [0.008240263376851 0.005515815051736 0.000022726070595];
M_IMU_To_Body = ZRot(pi)*EulerToDCM_321(Euler_IMU_To_Body);
Q_IMU_To_Body = DCMToquat(M_IMU_To_Body);

%% Magnetic Field Data
NorthAngle = -84*dtr; % Angle between X axis of table and magnetic North
M_North_To_ECEF = [ cos(NorthAngle) sin(NorthAngle) 0; ...
                   -sin(NorthAngle) cos(NorthAngle) 0; ...
                    0 0 1];

%% Range Sensors
% Center point of sensor
rangeSensorLocBody(1,:) = [0.5*platformWidth 0 0];
rangeSensorLocBody(2,:) = [0 0.5*platformLength 0];
rangeSensorLocBody(3,:) = [-0.5*platformWidth 0 0];
rangeSensorLocBody(4,:) = [0 -0.5*platformLength 0];

% Angle and field of view
rangeSensorAngBody = [0; 90*dtr; 180*dtr; 270*dtr];
% rangeSensorFOV = [4.4*dtr; 4.4*dtr; 4.4*dtr; 4.4*dtr];
rangeSensorFOV = [0*dtr; 0*dtr; 0*dtr; 0*dtr];

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