

if exist('sensedAccel','var')
    figure;plot(sensedAccel.Time,squeeze(sensedAccel.Data(1,:,:)));
    legend('x','y','z')
    title('Sensed Acceleration');xlabel('Time (s)');ylabel('Acceleration (g''s)');
end

if exist('sensedRate','var')
    figure;plot(sensedRate.Time,squeeze(sensedRate.Data(1,:,:)));
    legend('x','y','z')
    title('Sensed Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)');
end

if exist('sensedRange','var')
    figure;plot(sensedRange.Time,squeeze(sensedRange.Data(1,:,:)));
    legend('1','2','3','4')
    title('Sensed Range');xlabel('Time (s)');ylabel('Range (mm)');
end

if exist('filteredRate','var') && exist('sensedRate','var')
    figure;plot(sensedRate.Time,squeeze(sensedRate.Data(1,1,:)),filteredRate.Time,squeeze(filteredRate.Data(1,1,:)));
    legend('sensed x','filtered x')
    title('Filtered Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)');
end

if exist('filteredRate1','var')
    figure;plot(filteredRate1.Time,squeeze(filteredRate1.Data(1,1,:)));
    legend('x','y','z')
    title('Filtered Angular Rate 1');xlabel('Time (s)');ylabel('Angular Rate (deg/s)');
end