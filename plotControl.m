
dtr = pi/180;
rtd = 180/pi;

figure;
subplot(3,1,1);plot(refValues.Time,refValues.Data(:,1),stateOutECEF.Time,stateOutECEF.Data(:,1))
title('Reference Trajectory Tracking: X Position');xlabel('Time (s)');ylabel('Position (m)')
legend('Reference','Actual')

subplot(3,1,2);plot(refValues.Time,refValues.Data(:,2),stateOutECEF.Time,stateOutECEF.Data(:,2))
title('Reference Trajectory Tracking: Y Position');xlabel('Time (s)');ylabel('Position (m)')
legend('Reference','Actual')

subplot(3,1,3);plot(refValues.Time,refValues.Data(:,6)*rtd,stateOutECEF.Time,stateOutECEF.Data(:,6)*rtd)
title('Reference Trajectory Tracking: Theta Angle');xlabel('Time (s)');ylabel('Angle (deg)')
legend('Reference','Actual')

figure;
subplot(3,1,1);plot(refValues.Time,refValues.Data(:,7),stateOutECEF.Time,stateOutECEF.Data(:,7))
title('Reference Trajectory Tracking: X Velocity');xlabel('Time (s)');ylabel('Velocity (m/s)')
legend('Reference','Actual')

subplot(3,1,2);plot(refValues.Time,refValues.Data(:,8),stateOutECEF.Time,stateOutECEF.Data(:,8))
title('Reference Trajectory Tracking: Y Velocity');xlabel('Time (s)');ylabel('Velocity (m/s)')
legend('Reference','Actual')

subplot(3,1,3);plot(refValues.Time,refValues.Data(:,12)*rtd,stateOutECEF.Time,stateOutECEF.Data(:,12)*rtd)
title('Reference Trajectory Tracking: Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)')
legend('Reference','Actual')

figure;
subplot(2,1,1);plot(error1.Time,error1.Data(:,1),error1.Time,error1.Data(:,2))
title('Control Error ECEF: X Y Position');xlabel('Time (s)');ylabel('Position Error (m)')
legend('X','Y')

subplot(2,1,2);plot(error1.Time,error1.Data(:,6))
title('Control Error ECEF: Theta');xlabel('Time (s)');ylabel('Angle (deg)')

figure;
subplot(2,1,1);plot(PosError.Time,PosError.Data(:,1),PosError.Time,PosError.Data(:,2))
title('Control Error Body: X Y Position');xlabel('Time (s)');ylabel('Position Error (m)')
legend('X','Y')

subplot(2,1,2);plot(PosError.Time,PosError.Data(:,6))
title('Control Error Body: Theta');xlabel('Time (s)');ylabel('Angle (deg)')

figure;
subplot(3,1,1);plot(controlMoment.Time,controlMoment.Data(:,1),thrusterOut.Time,thrusterOut.Data(:,1))
title('Applied Force Body: X');xlabel('Time (s)');ylabel('Force (N)')
legend('Control','Effector')

subplot(3,1,2);plot(controlMoment.Time,controlMoment.Data(:,2),thrusterOut.Time,thrusterOut.Data(:,2))
title('Applied Force Body: Y');xlabel('Time (s)');ylabel('Force (N)')
legend('Control','Effector')

subplot(3,1,3);plot(controlMoment.Time,controlMoment.Data(:,6),thrusterOut.Time,thrusterOut.Data(:,6))
title('Applied Moment Body: Z');xlabel('Time (s)');ylabel('Moment (Nm)')
legend('Control','Effector')
