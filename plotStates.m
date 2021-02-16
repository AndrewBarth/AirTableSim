rtd = 180/pi;
ECEFpos = stateOutBus.TranState_ECEF.R_Sys_ECEF;
ECEFvel = stateOutBus.TranState_ECEF.V_Sys_ECEF;
Bodypos = stateOutBus.TranState_Body.R_Sys_Body;
Bodyvel = stateOutBus.TranState_Body.V_Sys_Body;
EulerAngles = stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler;
BodyRates = stateOutBus.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

figure;
subplot(2,1,1);plot(ECEFpos.Time,ECEFpos.Data(:,1))
xlabel('Time (s)');ylabel('Position (m)')
title('X Axis Position ECEF')
subplot(2,1,2);plot(ECEFpos.Time,ECEFpos.Data(:,2))
xlabel('Time (s)');ylabel('Position (m)')
title('Y Axis Position ECEF')

figure;
subplot(2,1,1);plot(ECEFvel.Time,ECEFvel.Data(:,1))
xlabel('Time (s)');ylabel('Velocity (m/s)')
title('X Axis Velocity ECEF')
subplot(2,1,2);plot(ECEFvel.Time,ECEFvel.Data(:,2))
xlabel('Time (s)');ylabel('Velocity (m/s)')
title('Y Axis Velocity ECEF')

figure;
subplot(2,1,1);plot(Bodypos.Time,Bodypos.Data(:,1))
xlabel('Time (s)');ylabel('Position (m)')
title('X Axis Position Body')
subplot(2,1,2);plot(Bodypos.Time,Bodypos.Data(:,2))
xlabel('Time (s)');ylabel('Position (m)')
title('Y Axis Position Body')

figure;
subplot(2,1,1);plot(Bodyvel.Time,Bodyvel.Data(:,1))
xlabel('Time (s)');ylabel('Velocity (m/s)')
title('X Axis Velocity Body')
subplot(2,1,2);plot(Bodyvel.Time,Bodyvel.Data(:,2))
xlabel('Time (s)');ylabel('Velocity (m/s)')
title('Y Axis Velocity Body')
figure;
plot(EulerAngles.Time,EulerAngles.Data(:,3)*rtd)
xlabel('Time (s)');ylabel('Theta (deg)')
title('Angular Position')

figure;
plot(BodyRates.Time,BodyRates.Data(:,3)*rtd)
xlabel('Time (s)');ylabel('Rate (deg/s)')
title('Angular Rate')