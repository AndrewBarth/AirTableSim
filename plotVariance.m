rtd = 180/pi;

ECEFpos = stateOutBus.TranState_ECEF.R_Sys_ECEF;
ECEFvel = stateOutBus.TranState_ECEF.V_Sys_ECEF;
EulerAngles = stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler;
BodyRates = stateOutBus.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

estECEFpos = estState.TranState_ECEF.R_Sys_ECEF;
estECEFvel = estState.TranState_ECEF.V_Sys_ECEF;
estEulerAngles = estState.RotState_Body_ECEF.ECEF_To_Body_Euler;
estBodyRates = estState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

figure;plot(ECEFpos.Time,ECEFpos.Data(:,1)-estECEFpos.Data(:,1))
hold all;
plot(PMat.Time,sqrt(squeeze((PMat.Data(1,1,:)))))
plot(PMat.Time,-sqrt(squeeze((PMat.Data(1,1,:)))))
xlabel('Time (s)');ylabel('Position Error (m)');title('X Axis Position Error')
legend('Error','Variance','Variance')

figure;plot(EulerAngles.Time,EulerAngles.Data(:,3)*rtd-estEulerAngles.Data(:,3)*rtd)
hold all;
plot(PMat.Time,sqrt(squeeze((PMat.Data(3,3,:)*rtd))))
plot(PMat.Time,-sqrt(squeeze((PMat.Data(3,3,:)*rtd))))
xlabel('Time (s)');ylabel('Angle Error (deg)');title('Angle Error')
legend('Error','Variance','Variance')
