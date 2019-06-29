dynamicsRate = 0.005;
controlRate = 0.025;
load('ConfigSet_RPi_DynamicsRate.mat');
load('ConfigSet_RPi_ControlRate.mat');

%% Configure sensor setup
VSS_SIMDYNAMICS = Simulink.Variant('VSS_MODE==0');
VSS_HWSENSOR    = Simulink.Variant('VSS_MODE==1');
VSS_SIMFILTERED = Simulink.Variant('VSS_MODE==2');
VSS_SIMSENSOR   = Simulink.Variant('VSS_MODE==3');
VSS_MODE = 1;



%% Rotational State Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'Body_To_ECEF_Euler';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';

elems(2) = Simulink.BusElement;
elems(2).Name = 'Body_To_ECEF_Quat';
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