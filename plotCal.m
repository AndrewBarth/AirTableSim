
figure;plot(filteredAccel.Time,squeeze(filteredAccel.Data(1,1,:)),filteredAccel.Time,squeeze(filteredAccel.Data(2,1,:)));
legend('x','y')
title('Filtered Acceleration');xlabel('Time (s)');ylabel('Acceleration (g)');


halfpts = int32(size(integratedVel.Time,1)/2);
figure;plot(integratedVel.Time,squeeze(integratedVel.Data(1:2,1,:)));
legend('x','y');xlabel('Time (s)');ylabel('Velocity (m/s)')
title('Integrated Velocity');

figure;plot(accelBias.Time(2:end),squeeze(accelBias.Data(1:2,1,2:end)));
legend('x','y');xlabel('Time (s)');ylabel('Accel Bias (m/s^2)')
title('Acceleration Bias');

fprintf('Accel Bias:  Mean         Std         EndVal\n')
fprintf('x:         %12.9f %12.9f %12.9f\n',nanmean(squeeze(accelBias.Data(1,1,halfpts:end))),nanstd(squeeze(accelBias.Data(1,1,halfpts:end))),accelBias.Data(1,1,end))
fprintf('y:         %12.9f %12.9f %12.9f\n',nanmean(squeeze(accelBias.Data(2,1,halfpts:end))),nanstd(squeeze(accelBias.Data(2,1,halfpts:end))),accelBias.Data(2,1,end))


figure;plot(filteredRate.Time,squeeze(filteredRate.Data(1,1,:)),filteredRate.Time,squeeze(filteredRate.Data(2,1,:)));
legend('x','y')
title('Filtered Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)');

    
halfpts = int32(size(integratedAng.Time,1)/2);
figure;plot(integratedAng.Time,squeeze(integratedAng.Data(1:3,1,:)*180/pi));
legend('x','y','z');xlabel('Time (s)');ylabel('Angle (deg)')
title('Integrated Angle');

figure;plot(rateBias.Time(2:end),squeeze(rateBias.Data(1:3,1,2:end)));
legend('x','y','z');xlabel('Time (s)');ylabel('Rate Bias (deg/s)')
title('Rate Bias');

fprintf('Rate Bias:   Mean         Std         EndVal\n')
fprintf('x:         %12.9f %12.9f %12.9f\n',nanmean(squeeze(rateBias.Data(1,1,halfpts:end))),nanstd(squeeze(rateBias.Data(1,1,halfpts:end))),rateBias.Data(1,1,end))
fprintf('y:         %12.9f %12.9f %12.9f\n',nanmean(squeeze(rateBias.Data(2,1,halfpts:end))),nanstd(squeeze(rateBias.Data(2,1,halfpts:end))),rateBias.Data(2,1,end))
fprintf('z:         %12.9f %12.9f %12.9f\n',nanmean(squeeze(rateBias.Data(3,1,halfpts:end))),nanstd(squeeze(rateBias.Data(3,1,halfpts:end))),rateBias.Data(3,1,end))

