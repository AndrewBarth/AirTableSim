
clear tOntime

figure;
subplot(4,1,1);plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,1))
title('Thruster 1');xlabel('Time (sec)');ylabel('On-Time (sec)')
subplot(4,1,2);plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,2))
title('Thruster 2');xlabel('Time (sec)');ylabel('On-Time (sec)')
subplot(4,1,3);plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,3))
title('Thruster 3');xlabel('Time (sec)');ylabel('On-Time (sec)')
subplot(4,1,4);plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,4))
title('Thruster 4');xlabel('Time (sec)');ylabel('On-Time (sec)')

figure;
subplot(4,1,1);plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,5))
title('Thruster 5');xlabel('Time (sec)');ylabel('On-Time (sec)')
subplot(4,1,2);plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,6))
title('Thruster 6');xlabel('Time (sec)');ylabel('On-Time (sec)')
subplot(4,1,3);plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,7))
title('Thruster 7');xlabel('Time (sec)');ylabel('On-Time (sec)')
subplot(4,1,4);plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,8))
title('Thruster 8');xlabel('Time (sec)');ylabel('On-Time (sec)')

for i=1:size(thrusterOnTimes.Time,1)
    tOntime(i) = sum(thrusterOnTimes.Data(i,:));
end

figure;plot(thrusterOnTimes.Time,tOntime)
title('Total On-Time');xlabel('Time (sec)');ylabel('On-Time (sec)')
