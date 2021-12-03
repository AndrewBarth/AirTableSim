
dtr = pi/180;
rtd = 180/pi;


ECEFpos = stateOutBus.TranState_ECEF.R_Sys_ECEF;
ECEFvel = stateOutBus.TranState_ECEF.V_Sys_ECEF;
EulerAngles = stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler;
BodyRates = stateOutBus.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;
ref.Time = refValues.Time;
ref.Data = squeeze(refValues.Data(1,:,:))';

figure;
subplot(3,1,1);plot(ref.Time,ref.Data(:,1),ECEFpos.Time,ECEFpos.Data(:,1))
title('Reference Trajectory Tracking: X Position ECEF');xlabel('Time (s)');ylabel('Position (m)')
legend('Reference','Actual')

subplot(3,1,2);plot(ref.Time,ref.Data(:,2),ECEFpos.Time,ECEFpos.Data(:,2))
title('Reference Trajectory Tracking: Y Position ECEF');xlabel('Time (s)');ylabel('Position (m)')
legend('Reference','Actual')

subplot(3,1,3);plot(ref.Time,ref.Data(:,6)*rtd,EulerAngles.Time,EulerAngles.Data(:,3)*rtd)
title('Reference Trajectory Tracking: Theta Angle');xlabel('Time (s)');ylabel('Angle (deg)')
legend('Reference','Actual')

figure;
subplot(3,1,1);plot(ref.Time,ref.Data(:,7),ECEFvel.Time,ECEFvel.Data(:,1))
title('Reference Trajectory Tracking: X Velocity ECEF');xlabel('Time (s)');ylabel('Velocity (m/s)')
legend('Reference','Actual')

subplot(3,1,2);plot(ref.Time,ref.Data(:,8),ECEFvel.Time,ECEFvel.Data(:,2))
title('Reference Trajectory Tracking: Y Velocity ECEF');xlabel('Time (s)');ylabel('Velocity (m/s)')
legend('Reference','Actual')

subplot(3,1,3);plot(ref.Time,ref.Data(:,12)*rtd,BodyRates.Time,BodyRates.Data(:,3)*rtd)
title('Reference Trajectory Tracking: Angular Rate');xlabel('Time (s)');ylabel('Angular Rate (deg/s)')
legend('Reference','Actual')

% figure;
% subplot(2,1,1);plot(controlErrorECEF.Time,controlErrorECEF.Data(:,1),controlErrorECEF.Time,controlErrorECEF.Data(:,2))
% title('Control Error ECEF: X Y Position');xlabel('Time (s)');ylabel('Position Error (m)')
% legend('X','Y')
% 
% subplot(2,1,2);plot(controlErrorECEF.Time,controlErrorECEF.Data(:,6)*rtd)
% title('Control Error ECEF: Theta');xlabel('Time (s)');ylabel('Angle (deg)')
% 
% figure;
% subplot(2,1,1);plot(controlErrorECEF.Time,controlErrorECEF.Data(:,7),controlErrorECEF.Time,controlErrorECEF.Data(:,8))
% title('Control Error ECEF: X Y Velocity');xlabel('Time (s)');ylabel('Velocity Error (m/s)')
% legend('X','Y')
% 
% subplot(2,1,2);plot(controlErrorECEF.Time,controlErrorECEF.Data(:,12)*rtd)
% title('Control Error ECEF: ThetaDot');xlabel('Time (s)');ylabel('Rate (deg/s)')

figure;
subplot(2,1,1);plot(controlErrorBody.Time,controlErrorBody.Data(:,1),controlErrorBody.Time,controlErrorBody.Data(:,2))
title('Control Error Body: X Y Position');xlabel('Time (s)');ylabel('Position Error (m)')
legend('X','Y')

subplot(2,1,2);plot(controlErrorBody.Time,controlErrorBody.Data(:,6)*rtd)
title('Control Error Body: Theta');xlabel('Time (s)');ylabel('Angle (deg)')

figure;
subplot(2,1,1);plot(controlErrorBody.Time,controlErrorBody.Data(:,7),controlErrorBody.Time,controlErrorBody.Data(:,8))
title('Control Error Body: X Y Velocity');xlabel('Time (s)');ylabel('Velocity Error (m/s)')
legend('X','Y')

subplot(2,1,2);plot(controlErrorBody.Time,controlErrorBody.Data(:,12)*rtd)
title('Control Error Body: ThetaDot');xlabel('Time (s)');ylabel('Rate (deg/s)')

figure;
subplot(3,1,1);plot(controlSignalBody.Time,controlSignalBody.Data(:,1),thrusterOut.Time,thrusterOut.Data(:,1))
title('Applied Force Body: X');xlabel('Time (s)');ylabel('Force (N)')
legend('Control','Effector')

subplot(3,1,2);plot(controlSignalBody.Time,controlSignalBody.Data(:,2),thrusterOut.Time,thrusterOut.Data(:,2))
title('Applied Force Body: Y');xlabel('Time (s)');ylabel('Force (N)')
legend('Control','Effector')

subplot(3,1,3);plot(controlSignalBody.Time,controlSignalBody.Data(:,6),thrusterOut.Time,thrusterOut.Data(:,6))
title('Applied Moment Body: Z');xlabel('Time (s)');ylabel('Moment (Nm)')
legend('Control','Effector')

% clear signs
% signs(1,:) = sign(controlSignalBody.Data(:,1).*thrusterOut.Data(:,1));
% signs(2,:) = sign(controlSignalBody.Data(:,2).*thrusterOut.Data(:,2));
% signs(6,:) = sign(controlSignalBody.Data(:,6).*thrusterOut.Data(:,6));
% figure;
% subplot(3,1,1);plot(controlSignalBody.Time,signs(1,:).*abs(controlSignalBody.Data(:,1)-thrusterOut.Data(:,1))')
% title('Delta Force Body: X');xlabel('Time (s)');ylabel('Force (N)')
% 
% subplot(3,1,2);plot(controlSignalBody.Time,signs(2,:).*abs(controlSignalBody.Data(:,2)-thrusterOut.Data(:,2))')
% title('Delta Force Body: Y');xlabel('Time (s)');ylabel('Force (N)')
% 
% subplot(3,1,3);plot(controlSignalBody.Time,signs(6,:).*abs(controlSignalBody.Data(:,6)-thrusterOut.Data(:,6))')
% title('Delta Moment Body: Z');xlabel('Time (s)');ylabel('Moment (Nm)')

