rtd = 180/pi;
ECEFpos = stateOutBus.TranState_ECEF.R_Sys_ECEF;
ECEFvel = stateOutBus.TranState_ECEF.V_Sys_ECEF;
EulerAngles = stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler;
BodyRates = stateOutBus.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

estECEFpos = estState.TranState_ECEF.R_Sys_ECEF;
estECEFvel = estState.TranState_ECEF.V_Sys_ECEF;
estEulerAngles = estState.RotState_Body_ECEF.ECEF_To_Body_Euler;
estBodyRates = estState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

% figure;
% subplot(2,1,1);plot(ECEFpos.Time,ECEFpos.Data(:,1),estECEFpos.Time,estECEFpos.Data(:,1))
% xlabel('Time (s)');ylabel('Position (m)');legend('True','Estimated')
% title('X Axis Position ECEF')
% subplot(2,1,2);plot(ECEFpos.Time,ECEFpos.Data(:,2),estECEFpos.Time,estECEFpos.Data(:,2))
% xlabel('Time (s)');ylabel('Position (m)');legend('True','Estimated')
% title('Y Axis Position ECEF')

figure;
subplot(2,1,1);plot(ECEFpos.Time,ECEFpos.Data(:,1),estECEFpos.Time,estECEFpos.Data(:,1))
xlabel('Time (s)');ylabel('Position (m)');legend('True','Estimated')
title('X Axis Position ECEF')
subplot(2,1,2);plot(ECEFpos.Time,ECEFpos.Data(:,1)-estECEFpos.Data(:,1))
xlabel('Time (s)');ylabel('Error (m)')
title('X Axis Position Error Plot')

figure;
subplot(2,1,1);plot(ECEFpos.Time,ECEFpos.Data(:,2),estECEFpos.Time,estECEFpos.Data(:,2))
xlabel('Time (s)');ylabel('Position (m)');legend('True','Estimated')
title('Y Axis Position ECEF')
subplot(2,1,2);plot(ECEFpos.Time,ECEFpos.Data(:,2)-estECEFpos.Data(:,2))
xlabel('Time (s)');ylabel('Error (m)')
title('Y Axis Position Error Plot')

% figure;
% subplot(2,1,1);plot(ECEFvel.Time,ECEFvel.Data(:,1),estECEFvel.Time,estECEFvel.Data(:,1))
% xlabel('Time (s)');ylabel('Velocity (m/s)');legend('True','Estimated')
% title('X Axis Velocity ECEF')
% subplot(2,1,2);plot(ECEFvel.Time,ECEFvel.Data(:,2),estECEFvel.Time,estECEFvel.Data(:,2))
% xlabel('Time (s)');ylabel('Velocity (m/s)');legend('True','Estimated')
% title('Y Axis Velocity ECEF')

figure;
subplot(2,1,1);plot(ECEFvel.Time,ECEFvel.Data(:,1),estECEFvel.Time,estECEFvel.Data(:,1))
xlabel('Time (s)');ylabel('Velocity (m/s)');legend('True','Estimated')
title('X Axis Velocity ECEF')
subplot(2,1,2);plot(ECEFvel.Time,ECEFvel.Data(:,1)-estECEFvel.Data(:,1))
xlabel('Time (s)');ylabel('Error (m/s)')
title('X Axis Velocity Error Plot')

figure;
subplot(2,1,1);plot(ECEFvel.Time,ECEFvel.Data(:,2),estECEFvel.Time,estECEFvel.Data(:,2))
xlabel('Time (s)');ylabel('Velocity (m/s)');legend('True','Estimated')
title('Y Axis Velocity ECEF')
subplot(2,1,2);plot(ECEFvel.Time,ECEFvel.Data(:,2)-estECEFvel.Data(:,2))
xlabel('Time (s)');ylabel('Error (m/s)')
title('Y Axis Velocity Error Plot')

figure;
subplot(2,1,1);plot(EulerAngles.Time,EulerAngles.Data(:,3)*rtd,estEulerAngles.Time,estEulerAngles.Data(:,3)*rtd)
xlabel('Time (s)');ylabel('Theta (deg)');legend('True','Estimated')
title('Angular Position')
subplot(2,1,2);plot(EulerAngles.Time,EulerAngles.Data(:,3)*rtd-estEulerAngles.Data(:,3)*rtd)
xlabel('Time (s)');ylabel('Error (deg)')
title('Angular Position Error Plot')

figure;
subplot(2,1,1);plot(BodyRates.Time,BodyRates.Data(:,3)*rtd,estBodyRates.Time,estBodyRates.Data(:,3)*rtd)
xlabel('Time (s)');ylabel('Rate (deg/s)');legend('True','Estimated')
title('Angular Rate')
subplot(2,1,2);plot(BodyRates.Time,BodyRates.Data(:,3)*rtd-estBodyRates.Data(:,3)*rtd)
xlabel('Time (s)');ylabel('Error (deg/s)')
title('Angular Rate Error Plot')