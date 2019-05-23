rtd = 180/pi;

figure;
subplot(2,1,1);plot(stateOutECEF.Time,stateOutECEF.Data(:,1))
xlabel('Time (s)');ylabel('Position (m)')
title('X Axis Position')
subplot(2,1,2);plot(stateOutECEF.Time,stateOutECEF.Data(:,2))
xlabel('Time (s)');ylabel('Position (m)')
title('Y Axis Position')

figure;
subplot(2,1,1);plot(stateOutECEF.Time,stateOutECEF.Data(:,7))
xlabel('Time (s)');ylabel('Velocity (m/s)')
title('X Axis Velocity')
subplot(2,1,2);plot(stateOutECEF.Time,stateOutECEF.Data(:,8))
xlabel('Time (s)');ylabel('Velocity (m/s)')
title('Y Axis Velocity')

figure;
plot(stateOutECEF.Time,stateOutECEF.Data(:,6)*rtd)
xlabel('Time (s)');ylabel('Theta (deg)')
title('Angular Position')

figure;
plot(stateOutECEF.Time,stateOutECEF.Data(:,12)*rtd)
xlabel('Time (s)');ylabel('Rate (deg/s)')
title('Anglular Rate')