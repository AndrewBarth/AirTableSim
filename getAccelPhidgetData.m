function [accelMeasurement,rateMeasurement,accelTimestamp,rateTimestamp]= getAccelPhidgetData(accelPhidget,gyroPhidget)
% Function to get data from the Phidget Accelerometer and Gyroscope Sensor
% The interface is defined through the Python API to the sensor
%
% Inputs: accelPhidget   handle to the accelerometer channel
%         gyroPhidget    handle to the gyroscope channel  
%
% Output: accelMeasurement 3 axis acceleration measurement in sensor body frame (g's) 3x1
%         rateMeasurement  3 axis angular rate measurement in sensor body frame (deg/s) 3x1
%         accelTimestamp   time at which the acceleration measurement was taken
%         rateTimestamp    time at which the rate measurement was taken
%
% Assumptions and Limitations:
%    Data is computed about the sensor body axes
%    The data processing interval on the sensor is set below. If the
%    calling routine is running faster than real-time there may be larger
%    apparent gaps in the acquired data
%
% Dependencies:
%    Phidget22 python library
%    The python path in matlab (py.sys.path) must be set up prior to execution
%
% References:
%    See phidgets.com website for API details
%    This rountine was constructed for the PhidgetSpatial Precision
%    3/3/3 High Resolution sensor (ID 1044_1B)
%
% Author: Andrew Barth
%
% Modification History:
%    May 31 2019 - Initial version
%


% Still need code to handle errors when the Phidget channel becomes
% detached

% Check to see if the sensor channel is already attached
% If not, set the required information and wait for attachment
% Once attach read the latest data from the sensor
    accelStatus = int64(accelPhidget.getAttached());
    if accelStatus == 0
%         accelPhidget.setDeviceSerialNumber(int32(484118));
        accelPhidget.setDeviceSerialNumber(int32(595407));
        accelPhidget.setIsHubPortDevice(int32(0));
        accelPhidget.openWaitForAttachment(int32(5000));
        pause(5);
        % The min data interval for this sensor is 4 ms
        accelPhidget.setDataInterval(int32(25));
        accelMeasurement(:)  = cell2mat(cell(accelPhidget.getAcceleration()));
        accelTimestamp        = double(accelPhidget.getTimestamp());
    else
        accelMeasurement(:)  = cell2mat(cell(accelPhidget.getAcceleration()));
        accelTimestamp        = double(accelPhidget.getTimestamp());
    end
    
    gyroStatus = int64(gyroPhidget.getAttached());
    if gyroStatus == 0
%         gyroPhidget.setDeviceSerialNumber(int32(484118));
        gyroPhidget.setDeviceSerialNumber(int32(595407));
        gyroPhidget.setIsHubPortDevice(int32(0));
        gyroPhidget.openWaitForAttachment(int32(5000));
        pause(5);
        % The min data interval for this sensor is 4 ms
        accelPhidget.setDataInterval(int32(25));
        rateMeasurement(:)   = cell2mat(cell(gyroPhidget.getAngularRate()));
        rateTimestamp        = double(gyroPhidget.getTimestamp());
    else
        rateMeasurement(:)   = cell2mat(cell(gyroPhidget.getAngularRate()));
        rateTimestamp        = double(gyroPhidget.getTimestamp());
    end
