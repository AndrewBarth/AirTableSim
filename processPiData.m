
runname = 'AirTableModel_7';


if length(dir(strcat(runname,'_*.mat'))) > 1
    % Stitch the mat files together
    Raspberrypi_MAT_stitcher(dir(strcat(runname,'_*.mat')));
    filename = strcat(runname,'__stitched.mat');
else
    filename = strcat(runname,'_1.mat');
end

% Load the stitched files
data=load(filename);

npts = length(data.rt_tout);

% Collect output data
time = data.rt_yout.signals(10).values;
thrusterCmdsA = data.rt_yout.signals(1);
filteredSensor = data.rt_yout.signals(2);
rawSensor = data.rt_yout.signals(3);
refTraj = data.rt_yout.signals(6);
controlErrorA = data.rt_yout.signals(7);
controlSignal = data.rt_yout.signals(9);
filteredState = data.rt_yout.signals(11);
estimatedState = data.rt_yout.signals(12);
thrusterFM = data.rt_yout.signals(13);

%% Thruster commands
thrusterCmds.Time = time;
thrusterCmds.Data = thrusterCmdsA.values;

%% Raw sensor data
% Raw position is in mm, convert to m
stateOutBus.TranState_ECEF.R_Sys_ECEF.Time = time;
stateOutBus.TranState_ECEF.R_Sys_ECEF.Data = rawSensor.values(:,15:17)/1000;

% Velocity is not part of the sensor data
stateOutBus.TranState_ECEF.V_Sys_ECEF.Time = time;
stateOutBus.TranState_ECEF.V_Sys_ECEF.Data = zeros(npts,3);

% Body frame position is not part of the sensor data
stateOutBus.TranState_Body.R_Sys_Body.Time = time;
stateOutBus.TranState_Body.R_Sys_Body.Data = zeros(npts,3);

% Body frame velocity is not part of the sensor data
stateOutBus.TranState_Body.V_Sys_Body.Time = time;
stateOutBus.TranState_Body.V_Sys_Body.Data = zeros(npts,3);

% Raw angles are in degrees, convert to rad
stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler.Time = time;
stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler.Data = rawSensor.values(:,18:20)*pi/180;  

% Raw rates are in degrees/s, convert to rad/s
stateOutBus.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Time = time;
stateOutBus.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Data = rawSensor.values(:,4:6)*pi/180;

%% Filtered sensor data
% Filtered position
filtSensor.TranState_ECEF.R_Sys_ECEF.Time = time;
filtSensor.TranState_ECEF.R_Sys_ECEF.Data = squeeze(filteredSensor.values(1,15:17,:));

% Velocity is not part of the sensor data
filtSensor.TranState_ECEF.V_Sys_ECEF.Time = time;
filtSensor.TranState_ECEF.V_Sys_ECEF.Data = zeros(npts,3);

% Body frame position is not part of the sensor data
filtSensor.TranState_Body.R_Sys_Body.Time = time;
filtSensor.TranState_Body.R_Sys_Body.Data = zeros(npts,3);

% Body frame velocity is not part of the sensor data
filtSensor.TranState_Body.V_Sys_Body.Time = time;
filtSensor.TranState_Body.V_Sys_Body.Data = zeros(npts,3);

% Filtered angles
filtSensor.RotState_Body_ECEF.ECEF_To_Body_Euler.Time = time;
filtSensor.RotState_Body_ECEF.ECEF_To_Body_Euler.Data = squeeze(filteredSensor.values(1,18:20,:));  

% Filtered rates 
filtSensor.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Time = time;
filtSensor.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Data = squeeze(filteredSensor.values(1,4:6,:));

%% Estimated states
% Estimated position
estState.TranState_ECEF.R_Sys_ECEF.Time = time;
estState.TranState_ECEF.R_Sys_ECEF.Data = estimatedState.values(:,11:13);

% Estimated velocity
estState.TranState_ECEF.V_Sys_ECEF.Time = time;
estState.TranState_ECEF.V_Sys_ECEF.Data = estimatedState.values(:,14:16);

% Estimated position in body frame
estState.TranState_Body.R_Sys_Body.Time = time;
estState.TranState_Body.R_Sys_Body.Data = estimatedState.values(:,17:19);

% Estimated velocity in body frame
estState.TranState_Body.V_Sys_Body.Time = time;
estState.TranState_Body.V_Sys_Body.Data = estimatedState.values(:,20:22);

% Estimated angles
estState.RotState_Body_ECEF.ECEF_To_Body_Euler.Time = time;
estState.RotState_Body_ECEF.ECEF_To_Body_Euler.Data = estimatedState.values(:,1:3);

% Estimated rates
estState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Time = time;
estState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Data = estimatedState.values(:,8:10);

%% Filtered states
% Filtered position
filtState.TranState_ECEF.R_Sys_ECEF.Time = time;
filtState.TranState_ECEF.R_Sys_ECEF.Data = filteredState.values(:,11:13);

% Filtered velocity
filtState.TranState_ECEF.V_Sys_ECEF.Time = time;
filtState.TranState_ECEF.V_Sys_ECEF.Data = filteredState.values(:,14:16);

% Filtered position in body frame
filtState.TranState_Body.R_Sys_Body.Time = time;
filtState.TranState_Body.R_Sys_Body.Data = filteredState.values(:,17:19);

% Filtered velocity in body frame
filtState.TranState_Body.V_Sys_Body.Time = time;
filtState.TranState_Body.V_Sys_Body.Data = filteredState.values(:,20:22);

% Filtered angles
filtState.RotState_Body_ECEF.ECEF_To_Body_Euler.Time = time;
filtState.RotState_Body_ECEF.ECEF_To_Body_Euler.Data = filteredState.values(:,1:3);

% Filtered rates
filtState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Time = time;
filtState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body.Data = filteredState.values(:,8:10);

%% Control errors
controlError.Time = time;
controlError.Data = controlErrorA.values;

%% Control signal
controlMoment.Time = time;
controlMoment.Data = controlSignal.values;

%% Thruster force/moment
thrusterOut.Time = time;
thrusterOut.Data = thrusterFM.values;

%% Reference trajectory
refValues.Time = time;
refValues.Data = refTraj.values;