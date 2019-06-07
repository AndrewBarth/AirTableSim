function [rangeMeasurement]= getRangePhidgetData(rangePhidget1,rangePhidget2,rangePhidget3,rangePhidget4)
% Function to get data from the Phidget range Sensor
% The interface is defined through the Python API to the sensor
%
% Inputs: rangePhidget1   handle to the first distance sensor channel
%         rangePhidget2   handle to the second distance sensor channel
%         rangePhidget3   handle to the third distance sensor channel
%         rangePhidget4   handle to the fourth distance sensor channel
%
% Output: rangeMeasurement scalar range measurement frome each distance sensor 1x4
%
% Assumptions and Limitations:
%    Assumes all range sensors are attached to a VINT hub
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
%    This rountine was constructed for the Phidget sonar sensor (ID DST1200_0)
%
% Author: Andrew Barth
%
% Modification History:
%    May 31 2019 - Initial version
%

% Check to see if the sensor channel is already attached
% If not, set the required information and wait for attachment
% Once attach read the latest data from the sensor
    rangeStatus = int64(rangePhidget1.getAttached());
    if rangeStatus == 0
        rangePhidget1.setDeviceSerialNumber(int32(538408));
        rangePhidget1.setHubPort(int32(0))
        rangePhidget1.openWaitForAttachment(int32(5000));
        pause(5);
        % The min data interval for this sensor is 100 ms
        rangePhidget1.setDataInterval(int32(100));
        rangeMeasurement(1)  = double(rangePhidget1.getDistance());
    else
        rangeMeasurement(1)  = double(rangePhidget1.getDistance());
    end

    rangeStatus = int64(rangePhidget2.getAttached());
    if rangeStatus == 0
        rangePhidget2.setDeviceSerialNumber(int32(538408));
        rangePhidget2.setHubPort(int32(2))
        rangePhidget2.openWaitForAttachment(int32(5000));
        pause(5);
        % The min data interval for this sensor is 100 ms
        rangePhidget2.setDataInterval(int32(100));
        rangeMeasurement(2)  = double(rangePhidget2.getDistance());
    else
        rangeMeasurement(2)  = double(rangePhidget2.getDistance());
    end
    
    rangeStatus = int64(rangePhidget3.getAttached());
    if rangeStatus == 0
        rangePhidget3.setDeviceSerialNumber(int32(538408));
        rangePhidget3.setHubPort(int32(3))
        rangePhidget3.openWaitForAttachment(int32(5000));
        pause(5);
        % The min data interval for this sensor is 100 ms
        rangePhidget3.setDataInterval(int32(100));
        rangeMeasurement(3)  = double(rangePhidget3.getDistance());
    else
        rangeMeasurement(3)  = double(rangePhidget3.getDistance());
    end
    
    rangeStatus = int64(rangePhidget4.getAttached());
    if rangeStatus == 0
        rangePhidget4.setDeviceSerialNumber(int32(538408));
        rangePhidget4.setHubPort(int32(5))
        rangePhidget4.openWaitForAttachment(int32(5000));
        pause(5);
        % The min data interval for this sensor is 100 ms
        rangePhidget4.setDataInterval(int32(100));
        rangeMeasurement(4)  = double(rangePhidget4.getDistance());
    else
        rangeMeasurement(4)  = double(rangePhidget4.getDistance());
    end

