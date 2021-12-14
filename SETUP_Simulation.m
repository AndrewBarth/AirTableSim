

addpath('plot_scripts')
addpath('test_scripts')
addpath('utilities','-begin');

% Set the source of the sensor data
VSS_SIMDYNAMICS = Simulink.Variant('VSS_MODE==0');
VSS_HWSENSOR    = Simulink.Variant('VSS_MODE==1');
VSS_SIMSENSOR   = Simulink.Variant('VSS_MODE==2');
VSS_MODE = 1;

% Set the source of the input parameters
% When running within Matlab/Simulink use workspace data
% When running the generated code, use input port data
VSS_WORKSPACEDATA = Simulink.Variant('VSS_INPUT==0');
VSS_INPUTPORT     = Simulink.Variant('VSS_INPUT==1');
VSS_INPUT = 1;

% Configure Navigation type
navType = 4;    % 1: True State 2: Measured State 3: Filtered State 4: Estimated State

% Set the reference trajecotry
refIdx = 5;

% Set type of controller to use
controlType = 3;   % 1 sliding mode, 2 PID, 3 Phase Plane

% Set sim execution rates
dynamicsRate = 0.0125;
controlRate = 0.025;
load('ConfigSet_RPi_DynamicsRate.mat');
load('ConfigSet_RPi_ControlRate.mat');

initialState = [0.5 0 0*pi/180 0 0 0];

% Load additional parameters
loadBusData
loadControlData
loadSensorData
loadThrusterData

endTime = 100;
% endTime = 10;




