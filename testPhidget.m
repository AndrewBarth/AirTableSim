
accelActive = 1;
gyroActive = 1;
magActive = 1;
rangeActive = 0;


coder.extrinsic('py.Accelerometer.Accelerometer');
% addpath("C:\Program Files\MATLAB\R2018b\toolbox\matlab\external\interfaces\python");
% addpath("C:\Program Files");
% addpath("C:\Program Files\Python-3.5.7");
P = py.sys.path;
pathval{1} = 'Z:\My Documents\Phidget22Python';
pathval{2} = 'Z:\My Documents\Phidget22Python\Phidget22';
pathval{3} = 'Z:\My Documents\Phidget22Python\Phidget22\Devices';
pathval{4} = 'Z:\My Documents\MATLAB\AirTableSim';
for i = 1:size(pathval,2)
    if count(P,pathval{i}) == 0
        insert(P,int32(0),pathval{i});
    end
end

% Create Accelerometer object
if accelActive
    accelPhidget = py.Accelerometer.Accelerometer;
    accelPhidget.setDeviceSerialNumber(int32(595407));
    accelPhidget.setIsHubPortDevice(int32(0));
    
    accelPhidget2 = py.Accelerometer.Accelerometer;
    accelPhidget2.setDeviceSerialNumber(int32(484118));
    accelPhidget2.setIsHubPortDevice(int32(0));
end

% Create a Gyroscope object
if gyroActive
    gyroPhidget = py.Gyroscope.Gyroscope;
    gyroPhidget.setDeviceSerialNumber(int32(595407));
    gyroPhidget.setIsHubPortDevice(int32(0)); 
    
    gyroPhidget2 = py.Gyroscope.Gyroscope;
    gyroPhidget2.setDeviceSerialNumber(int32(484118));
    gyroPhidget2.setIsHubPortDevice(int32(0)); 
end

% Create a Magnetometer object
if magActive
    magPhidget = py.Magnetometer.Magnetometer;
    magPhidget.setDeviceSerialNumber(int32(595407));
    magPhidget.setIsHubPortDevice(int32(0));
    
    magPhidget2 = py.Magnetometer.Magnetometer;
    magPhidget2.setDeviceSerialNumber(int32(484118));
    magPhidget2.setIsHubPortDevice(int32(0));
end

% Create a Distance Sensor object
if rangeActive
    distPhidget1 = py.DistanceSensor.DistanceSensor;
    distPhidget1.setDeviceSerialNumber(int32(538408));
    distPhidget1.setHubPort(int32(0));

    distPhidget2 = py.DistanceSensor.DistanceSensor;
    distPhidget2.setDeviceSerialNumber(int32(538408));
    distPhidget2.setHubPort(int32(1));

    distPhidget3 = py.DistanceSensor.DistanceSensor;
    distPhidget3.setDeviceSerialNumber(int32(538408));
    distPhidget3.setHubPort(int32(4));

    distPhidget4 = py.DistanceSensor.DistanceSensor;
    distPhidget4.setDeviceSerialNumber(int32(538408));
    distPhidget4.setHubPort(int32(5));
end

% Attach to the device
try
    if accelActive
        accelPhidget.openWaitForAttachment(int32(5000));
        
        accelPhidget2.openWaitForAttachment(int32(5000));
    end
    if gyroActive
        gyroPhidget.openWaitForAttachment(int32(5000));
        
        gyroPhidget2.openWaitForAttachment(int32(5000));
    end
    if magActive
        magPhidget.openWaitForAttachment(int32(5000));
        
        magPhidget2.openWaitForAttachment(int32(5000));
    end
    if rangeActive
        distPhidget1.openWaitForAttachment(int32(5000));
        distPhidget2.openWaitForAttachment(int32(5000));
        distPhidget3.openWaitForAttachment(int32(5000));
        distPhidget4.openWaitForAttachment(int32(5000));
    end
catch
    disp('Error attaching to Phidgets')
end
pause(30);

% Set the rate at which the device will gather data
if accelActive
    accelPhidget.setDataInterval(int32(10));
    
    accelPhidget2.setDataInterval(int32(10));
end
if gyroActive
    gyroPhidget.setDataInterval(int32(10));
    
    gyroPhidget2.setDataInterval(int32(10));
end
if magActive
    magPhidget.setDataInterval(int32(10));
    
    magPhidget2.setDataInterval(int32(10));
end
if rangeActive
    distPhidget1.setDataInterval(int32(100));
    distPhidget2.setDataInterval(int32(100));
    distPhidget3.setDataInterval(int32(100));
    distPhidget4.setDataInterval(int32(100));
end

disp('collecting data:')
for i=1:100
    if accelActive
        accelMeasurement(i,:) = cell2mat(cell(accelPhidget.getAcceleration()));
        
        accelMeasurement2(i,:) = cell2mat(cell(accelPhidget2.getAcceleration()));
    end
    if gyroActive
        rateMeasurement(i,:)  = cell2mat(cell(gyroPhidget.getAngularRate()));
        
        rateMeasurement2(i,:)  = cell2mat(cell(gyroPhidget2.getAngularRate()));
    end
    if magActive
        magFieldMeasurement(i,:)  = cell2mat(cell(magPhidget.getMagneticField()));
        
        magFieldMeasurement2(i,:)  = cell2mat(cell(magPhidget2.getMagneticField()));
    end
    if rangeActive
        distMeasurement(i,1) = double(distPhidget1.getDistance());
        distMeasurement(i,2) = double(distPhidget2.getDistance());
        distMeasurement(i,3) = double(distPhidget1.getDistance());
        distMeasurement(i,4) = double(distPhidget2.getDistance());
    end
    pause(.10);
end

if accelActive
    accelPhidget.close();
    
    accelPhidget2.close();
end
if gyroActive
    gyroPhidget.close();
    
    gyroPhidget2.close();
end
if magActive
    magPhidget.close();
    
    magPhidget2.close();
end
if rangeActive
    distPhidget1.close();
    distPhidget2.close();
    distPhidget3.close();
    distPhidget4.close();
end
clear accelPhidget gyroPhidget magPhidget distPhidget1 distPhidget2 distPhidget3 distPhidget4




