% dynamicsRate = 0.0125;
% controlRate = 0.025;
dynamicsRate = 0.0125;
controlRate = 0.025;
load('ConfigSet_RPi_DynamicsRate.mat');
load('ConfigSet_RPi_ControlRate.mat');

addpath('utilities','-begin');

controlType = 2;   % 1 sliding mode, 2 PID
% Kp = [100 100 0 0 0 30];
% Kd = [200 200 0 0 0 10];
% Ki = [0 0 0 0 0 0];
% 
% Kp = [90.0275  148.5641 0 0 0 41.2792];
% Kd = [99.8064   99.8232 0 0 0 14.3925];
% Ki = [12.5056   23.2486 0 0 0 1.9867];

Kp = [70 70 0 0 0 20];
Kd = [80 80 0 0 0 5];
Ki = [4  4  0 0 0  1];

Kp = [70 70 0 0 0 20].*[.2 .2  0 0 0 .25];
Kd = [80 80 0 0 0 5] .*[.2 .2  0 0 0 .1];
Ki = [4  4  0 0 0 1] .*[1   1  0 0 0 0];

Kp = [70 70 0 0 0 20].*[.2 .2  0 0 0 .25];
Kd = [80 80 0 0 0 5] .*[.2 .2  0 0 0 .1];
Ki = [4  4  0 0 0 1] .*[1   1  0 0 0 .5];
% 
% Kp = [70 70   0 0 0 20]*.01;
% Kd = [80 80 0 0 0 5]*.1;
% Ki = [4  4  0 0 0  1]*.01;
% Kp = [500.0000  246.1321 0 0 0 50.1701];
% Kd = [500.0000  501.0938 0 0 0 18.4778];
% Ki = [1.0000    1.0313   0 0 0 58.1181];

% Kp = [23.0083  241.1549 0 0 0 20.0000];
% Kd = [500.0000 331.8547 0 0 0  8.0000];
% Ki = [1.0000    0.5000  0 0 0  0];
% Kp = [50.0  50.0 0 0 0  10.0000];
% Kd = [130.0 130.0 0 0 0  5.0000];
% Ki = [0 0 0 0 0 0];

% Kp = [50.0000  155.9614  0   0 0 48.6550];
% Kd = [131.0000  130.0000 0   0 0  5.0000];
% Ki = [  1.0000    1.0000 0   0 0  0];

% SMGains = [2 2 2 2 2 4 1];
% SMGains = [1.6264    1.5585    4.8510    8.0133    1.6984    4.8066    1.2611];
% SMGains = [2.0801    3.0489    8.9333    4.9881    3.0029    9.5293    0.6944    2.9403    3.0662];
SMGains = [3.5078    3.9888    6.3119    1.8214    4.7749    7.3059    3.6553    1.9774    4.3207];
% SMGains = [1 1 2 1 1 1 1 1 1];
% SMGains = [2 2 12 2 2 1 1 1 10];
% SMGains = [8.6506    4.1815    6.1690    9.8805    6.3439    0.1717    1.0000   13.0080   10.0000];

initialState = [0.5 0 0*pi/180 0 0 0];
initialNavState = [initialState + [0.01 -0.01 1e-3 0 0 1e-3]];
% initialNavState = [[initialState + [0.01 -0.01 1e-3 0 0 1e-3]] 0 0 0];
% initialState = [0.5 0 30*pi/180 0 0 0 0 0 0];
initialCovariance = diag([.01^2 .01^2 (2e-2*pi/180)^2 0 0 (1e-3*pi/180)^2] );
initialCovariance = diag([999999 999999 999999 999999 999999 999999]);

processNoise = 0;

% measurementNoise = [1e-2 5e-2*pi/180 1e-3*pi/180 2e-2]*100;
measurementNoise = [1 .0873 0.0017 2].* [1 1 1 1];
measurementNoise = [1 .0873 0.0017 2].* [.01 1 1 .01];

accelNoisePow = [.0000001 .0000001 .0000001]/.1;    % Want 2e-2 m/s2
rateNoisePow  = [.0000001 .0000001 .0000001]/20;    % Want 1e-3 deg/s
posNoisePow   = [.00001 .00001 .00001]/100;         % Want 1e-2 m (1 cm)
angNoisePow   = [.00001 .00001 .00001]/10;          % Want 2e-2  deg
accelNoisePow = [.0000001 .0000001 .0000001]/10;    % Want 2e-2 m/s2


%% Configure sensor setup
VSS_SIMDYNAMICS = Simulink.Variant('VSS_MODE==0');
VSS_HWSENSOR    = Simulink.Variant('VSS_MODE==1');
VSS_SIMSENSOR   = Simulink.Variant('VSS_MODE==2');
VSS_MODE = 1;

% Configure Navigation type
navType = 4;    % 1: True State 2: Measured State 3: Filtered State 4: Estimated State

%% Control Output Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'controlSignal';
elems(1).Dimensions = 6;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real'; 

elems(2) = Simulink.BusElement;
elems(2).Name = 'controlError';
elems(2).Dimensions = 12;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

elems(3) = Simulink.BusElement;
elems(3).Name = 'posError';
elems(3).Dimensions = 6;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';

ControlOutBus = Simulink.Bus;
ControlOutBus.Elements = elems;

ControlOutStruct  = Simulink.Bus.createMATLABStruct('ControlOutBus');

%% Rotational State Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'ECEF_To_Body_Euler';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';

elems(2) = Simulink.BusElement;
elems(2).Name = 'ECEF_To_Body_Quat';
elems(2).Dimensions = 4;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

elems(3) = Simulink.BusElement;
elems(3).Name = 'BodyRates_wrt_ECEF_In_Body';
elems(3).Dimensions = 3;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';

RotStateBodyECEFBus = Simulink.Bus;
RotStateBodyECEFBus.Elements = elems;

%% Translational State ECEF Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'R_Sys_ECEF';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';

elems(2) = Simulink.BusElement;
elems(2).Name = 'V_Sys_ECEF';
elems(2).Dimensions = 3;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

TranStateECEFBus = Simulink.Bus;
TranStateECEFBus.Elements = elems;

%% Translational State Body Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'R_Sys_Body';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';

elems(2) = Simulink.BusElement;
elems(2).Name = 'V_Sys_Body';
elems(2).Dimensions = 3;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

TranStateBodyBus = Simulink.Bus;
TranStateBodyBus.Elements = elems;

%% Full State Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'RotState_Body_ECEF';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'RotStateBodyECEFBus';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';

elems(2) = Simulink.BusElement;
elems(2).Name = 'TranState_ECEF';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'TranStateECEFBus';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

elems(3) = Simulink.BusElement;
elems(3).Name = 'TranState_Body';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'TranStateBodyBus';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';

FullStateBus = Simulink.Bus;
FullStateBus.Elements = elems;

StateStruct = Simulink.Bus.createMATLABStruct('FullStateBus');
clear elems;