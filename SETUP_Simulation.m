


% Set the source of the sensor data
VSS_SIMDYNAMICS = Simulink.Variant('VSS_MODE==0');
VSS_HWSENSOR    = Simulink.Variant('VSS_MODE==1');
VSS_SIMSENSOR   = Simulink.Variant('VSS_MODE==2');
VSS_MODE = 0;

% Load additional parameters
loadBusData
loadSensorData
loadThrusterData