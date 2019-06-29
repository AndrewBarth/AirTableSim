function [magFieldMeasurement,magTimestamp]= getMagnetometerPhidgetData(magPhidget)
% Function to get data from the Phidget Magnetometer Sensor
% The interface is defined through the Python API to the sensor
%
% Inputs: magPhidget          handle to the magnetometer channel 
%         magTimestamp        timestamp for the magnetic field measurement
%
% Output: magFieldMeasurement 3 axis magnetic field measurement in sensor body frame (Gauss) 3x1
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
%    Jun 20 2019 - Initial version
%


% Still need code to handle errors when the Phidget channel becomes
% detached

% Check to see if the sensor channel is already attached
% If not, set the required information and wait for attachment
% Once attach read the latest data from the sensor
    magStatus = int64(magPhidget.getAttached());
    if magStatus == 0
%         magPhidget.setDeviceSerialNumber(int32(484118));
        magPhidget.setDeviceSerialNumber(int32(595407));
        magPhidget.setIsHubPortDevice(int32(0));
        magPhidget.openWaitForAttachment(int32(5000));
        pause(5);
        % The min data interval for this sensor is 4 ms
        magPhidget.setDataInterval(int32(10));
        magFieldMeasurement(:)  = cell2mat(cell(magPhidget.getMagneticField()));
        magTimestamp            = double(magPhidget.getTimestamp());
    else
        magFieldMeasurement(:)  = cell2mat(cell(magPhidget.getMagneticField()));
        magTimestamp       = double(magPhidget.getTimestamp());
    end