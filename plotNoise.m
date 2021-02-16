rtd = 180/pi;
noisyData = processedSensorData;


ECEFpos = currentState.TranState_ECEF.R_Sys_ECEF;
EulerAngles = currentState.RotState_Body_ECEF.ECEF_To_Body_Euler;
BodyRates = currentState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;
Acceleration = currentAcceleration;

figure;subplot(2,1,1);plot(Acceleration.Time,Acceleration.Data(:,1),noisyData.Time,noisyData.Data(:,1));
       xlabel('Time (s)');ylabel('Acceleration (m/s2)');title('Sensed X Acceleration');legend('True','Sensed')
       subplot(2,1,2);plot(Acceleration.Time,(Acceleration.Data(:,1)-noisyData.Data(:,1)))
       xlabel('Time (s)');ylabel('Error (m/s2)');title('Sensed X Acceleration Error Plot')
       
figure;subplot(2,1,1);plot(Acceleration.Time,Acceleration.Data(:,2),noisyData.Time,noisyData.Data(:,2));
       xlabel('Time (s)');ylabel('Acceleration (m/s2)');title('Sensed Y Acceleration');legend('True','Sensed')
       subplot(2,1,2);plot(Acceleration.Time,(Acceleration.Data(:,2)-noisyData.Data(:,2)))
       xlabel('Time (s)');ylabel('Error (m/s2)');title('Sensed Y Acceleration Error Plot')
       
figure;subplot(2,1,1);plot(EulerAngles.Time,EulerAngles.Data(:,3)*rtd,noisyData.Time,noisyData.Data(:,20)*rtd);
       xlabel('Time (s)');ylabel('Theta (deg)');title('Sensed Theta Angle');legend('True','Sensed')
       subplot(2,1,2);plot(EulerAngles.Time,(EulerAngles.Data(:,3)-noisyData.Data(:,20)))
       xlabel('Time (s)');ylabel('Error (deg)');title('Sensed Theta Error Plot')
       
figure;subplot(2,1,1);plot(BodyRates.Time,BodyRates.Data(:,3)*rtd,noisyData.Time,noisyData.Data(:,6)*rtd);
       xlabel('Time (s)');ylabel('Rate (deg/s)');title('Sensed Body Rate');legend('True','Sensed')
       subplot(2,1,2);plot(BodyRates.Time,(BodyRates.Data(:,3)-noisyData.Data(:,6)))
       xlabel('Time (s)');ylabel('Error (deg/s)');title('Sensed Body Rate Error Plot')
       
figure;subplot(2,1,1);plot(ECEFpos.Time,ECEFpos.Data(:,1),noisyData.Time,noisyData.Data(:,15));
       xlabel('Time (s)');ylabel('Position (m)');title('Sensed X Position');legend('True','Sensed')
       subplot(2,1,2);plot(ECEFpos.Time,(ECEFpos.Data(:,1)-noisyData.Data(:,15)))
       xlabel('Time (s)');ylabel('Error (m)');title('Sensed X Position Error Plot')
       
figure;subplot(2,1,1);plot(ECEFpos.Time,ECEFpos.Data(:,2),noisyData.Time,noisyData.Data(:,16));
       xlabel('Time (s)');ylabel('Position (m)');title('Sensed Y Position');legend('True','Sensed')
       subplot(2,1,2);plot(ECEFpos.Time,(ECEFpos.Data(:,2)-noisyData.Data(:,16)))
       xlabel('Time (s)');ylabel('Error (m)');title('Sensed Y Position Error Plot')