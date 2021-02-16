
dtr = pi/180;
rtd = 180/pi;
ref.Time = refValues.Time;
ref.Data = squeeze(refValues.Data(1,:,:))';

figure;
subplot(3,1,1);plot(ref.Time,ref.Data(:,1))
title('Reference Trajectory: X Position');xlabel('Time (s)');ylabel('Position (m)')
axis([-Inf Inf 0 1.1*max(ref.Data(:,1))])

subplot(3,1,2);plot(ref.Time,ref.Data(:,2))
title('Reference Trajectory: Y Position');xlabel('Time (s)');ylabel('Position (m)')
axis([-Inf Inf 0 1.1*max(ref.Data(:,2))])

subplot(3,1,3);plot(ref.Time,ref.Data(:,6)*rtd)
title('Reference Trajectory: Theta Angle');xlabel('Time (s)');ylabel('Angle (deg)')
axis([-Inf Inf 0 1.1*max(ref.Data(:,6)*rtd)])

figure;
subplot(3,1,1);plot(ref.Time,ref.Data(:,7))
title('Reference Trajectory: X Velocity');xlabel('Time (s)');ylabel('Velocity (m/s)')
axis([-Inf Inf 0 1.1*max(ref.Data(:,7))])

subplot(3,1,2);plot(ref.Time,ref.Data(:,8))
title('Reference Trajectory: Y Velocity');xlabel('Time (s)');ylabel('Velocity (m/s)')
axis([-Inf Inf 0 1.1*max(ref.Data(:,8))])

subplot(3,1,3);plot(ref.Time,ref.Data(:,12)*rtd)
title('Reference Trajectory: Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)')
axis([-Inf Inf 0 1.1*max(ref.Data(:,12)*rtd)])