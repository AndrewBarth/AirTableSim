

% if exist('sensedAccel','var')
%     figure;plot(sensedAccel.Time,squeeze(sensedAccel.Data(1,:,:)));
%     legend('x','y','z')
%     title('Sensed Acceleration');xlabel('Time (s)');ylabel('Acceleration (g''s)');
% end
% 
% if exist('sensedRate','var')
%     figure;plot(sensedRate.Time,squeeze(sensedRate.Data(1,:,:)));
%     legend('x','y','z')
%     title('Sensed Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)');
% end
% 
% if exist('sensedRange','var')
%     figure;plot(sensedRange.Time,squeeze(sensedRange.Data(1,:,:)));
%     legend('1','2','3','4')
%     title('Sensed Range');xlabel('Time (s)');ylabel('Range (mm)');
% end

if exist('filteredRate','var') && exist('unFilteredRate','var')
    figure;
    subplot(3,1,1);plot(unFilteredRate.Time,squeeze(unFilteredRate.Data(1,1,:)),filteredRate.Time,squeeze(filteredRate.Data(1,1,:)));
    legend('unFiltered','Filtered')
    title('X Axis Filtered Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)');
    
    subplot(3,1,2);plot(unFilteredRate.Time,squeeze(unFilteredRate.Data(2,1,:)),filteredRate.Time,squeeze(filteredRate.Data(2,1,:)));
    legend('unFiltered','Filtered')
    title('Y Axis Filtered Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)');
    
    subplot(3,1,3);plot(unFilteredRate.Time,squeeze(unFilteredRate.Data(3,1,:)),filteredRate.Time,squeeze(filteredRate.Data(3,1,:)));
    legend('unFiltered','Filtered')
    title('Z Axis Filtered Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)');
    
    
end


if exist('filteredAccel','var') && exist('unFilteredAccel','var')
    figure;
    subplot(3,1,1);plot(unFilteredAccel.Time,squeeze(unFilteredAccel.Data(1,1,:)),filteredAccel.Time,squeeze(filteredAccel.Data(1,1,:)));
    legend('unFiltered','Filtered')
    title('X Axis Filtered Acceleration');xlabel('Time (s)');ylabel('Acceleration (g)');
    
    subplot(3,1,2);plot(unFilteredAccel.Time,squeeze(unFilteredAccel.Data(2,1,:)),filteredAccel.Time,squeeze(filteredAccel.Data(2,1,:)));
    legend('unFiltered','Filtered')
    title('Y Axis Filtered Acceleration');xlabel('Time (s)');ylabel('Acceleration (g)');
    
    subplot(3,1,3);plot(unFilteredAccel.Time,squeeze(unFilteredAccel.Data(3,1,:)),filteredAccel.Time,squeeze(filteredAccel.Data(3,1,:)));
    legend('unFiltered','Filtered')
    title('Z Axis Filtered Acceleration');xlabel('Time (s)');ylabel('Acceleration (g)');
end

if exist('sensorData','var')
    figure;
    plot(sensorData.Time,squeeze(sensorData.Data(:,11:13)));
    legend('X','Y','Z');
    title('Magnetic Field Data');xlabel('Time (s)');ylabel('Magnetic Field (gauss)');
    
    figure;
    plot(sensorData.Time,squeeze(sensorData.Data(:,7:10)));
    legend('Sensor 1','Sensor 2','Sensor 3','Sensor 4');
    title('Range Data Data');xlabel('Time (s)');ylabel('Range (m)');
end