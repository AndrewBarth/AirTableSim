rtd = 180/pi;

ECEFvel     = stateOutBus.TranState_ECEF.V_Sys_ECEF;
measECEFvel = measState.TranState_ECEF.V_Sys_ECEF;
filtECEFvel = filtState.TranState_ECEF.V_Sys_ECEF;
estECEFvel  = estState.TranState_ECEF.V_Sys_ECEF;



figure;
subplot(2,1,1);plot(measECEFvel.Time,measECEFvel.Data(:,1))
xlabel('Time (s)');ylabel('Velocity (m/s)');legend('Measured')
title('X Axis Velocity ECEF')
subplot(2,1,2);plot(filtECEFvel.Time,filtECEFvel.Data(:,1),estECEFvel.Time,estECEFvel.Data(:,1),ECEFvel.Time,ECEFvel.Data(:,1))
xlabel('Time (s)');ylabel('Velocity (m/s)');legend('Filtered','Estimated','True')
title('X Axis Velocity ECEF')
% subplot(2,1,2);plot(ECEFvel.Time,ECEFvel.Data(:,2),estECEFvel.Time,estECEFvel.Data(:,2))
% xlabel('Time (s)');ylabel('Velocity (m/s)');legend('True','Estimated')
% title('Y Axis Velocity ECEF')

