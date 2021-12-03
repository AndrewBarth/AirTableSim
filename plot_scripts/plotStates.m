% Script to compare the True state to the filtered and estimated states

plotFiltered = 1;
plotEstimated = 1;

rtd = 180/pi;
ECEFpos = stateOutBus.TranState_ECEF.R_Sys_ECEF;
ECEFvel = stateOutBus.TranState_ECEF.V_Sys_ECEF;
EulerAngles = stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler;
BodyRates = stateOutBus.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

filtECEFpos = filtState.TranState_ECEF.R_Sys_ECEF;
filtECEFvel = filtState.TranState_ECEF.V_Sys_ECEF;
filtEulerAngles = filtState.RotState_Body_ECEF.ECEF_To_Body_Euler;
filtBodyRates = filtState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

estECEFpos = estState.TranState_ECEF.R_Sys_ECEF;
estECEFvel = estState.TranState_ECEF.V_Sys_ECEF;
estEulerAngles = estState.RotState_Body_ECEF.ECEF_To_Body_Euler;
estBodyRates = estState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

nPlots = 1 + plotFiltered + plotEstimated;


figure;
subplot(nPlots,1,1);plot(ECEFpos.Time,ECEFpos.Data(:,1)); hold all;
clear legendText
legendText{1} = 'True';
if plotFiltered == 1
    plot(filtECEFpos.Time,filtECEFpos.Data(:,1))
    legendText{end+1} = 'Filtered';
end
if plotEstimated == 1
    plot(estECEFpos.Time,estECEFpos.Data(:,1))
    legendText{end+1} = 'Estimated'; 
end
xlabel('Time (s)');ylabel('Position (m)'); legend(legendText)
title('X Axis Position ECEF')
n = 1;
if plotFiltered == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(ECEFpos.Time,ECEFpos.Data(:,1)-filtECEFpos.Data(:,1))
    xlabel('Time (s)');ylabel('Error (m)')
    title('X Axis Position Error Plot (True - Filtered)')
end
if plotEstimated == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(ECEFpos.Time,ECEFpos.Data(:,1)-estECEFpos.Data(:,1))
    xlabel('Time (s)');ylabel('Error (m)')
    title('X Axis Position Error Plot (True - Estimated)')
end

figure;
subplot(nPlots,1,1);plot(ECEFpos.Time,ECEFpos.Data(:,2)); hold all;
clear legendText
legendText{1} = 'True';
if plotFiltered == 1
    plot(filtECEFpos.Time,filtECEFpos.Data(:,2))
    legendText{end+1} = 'Filtered';
end
if plotEstimated == 1
    plot(estECEFpos.Time,estECEFpos.Data(:,2))
    legendText{end+1} = 'Estimated'; 
end
xlabel('Time (s)');ylabel('Position (m)'); legend(legendText)
title('Y Axis Position ECEF')
n = 1;
if plotFiltered == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(ECEFpos.Time,ECEFpos.Data(:,2)-filtECEFpos.Data(:,2))
    xlabel('Time (s)');ylabel('Error (m)')
    title('Y Axis Position Error Plot (True - Filtered)')
end
if plotEstimated == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(ECEFpos.Time,ECEFpos.Data(:,2)-estECEFpos.Data(:,2))
    xlabel('Time (s)');ylabel('Error (m)')
    title('Y Axis Position Error Plot (True - Estimated)')
end

figure;
subplot(nPlots,1,1);plot(ECEFvel.Time,ECEFvel.Data(:,1)); hold all;
clear legendText
legendText{1} = 'True';
if plotFiltered == 1
    plot(filtECEFvel.Time,filtECEFvel.Data(:,1))
    legendText{end+1} = 'Filtered';
end
if plotEstimated == 1
    plot(estECEFvel.Time,estECEFvel.Data(:,1))
    legendText{end+1} = 'Estimated'; 
end
xlabel('Time (s)');ylabel('Velocity (m/s)'); legend(legendText)
title('X Axis Velocity ECEF')
n = 1;
if plotFiltered == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(ECEFvel.Time,ECEFvel.Data(:,1)-filtECEFvel.Data(:,1))
    xlabel('Time (s)');ylabel('Error (m/s)')
    title('X Axis Velocity Error Plot (True - Filtered)')
end
if plotEstimated == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(ECEFvel.Time,ECEFvel.Data(:,1)-estECEFvel.Data(:,1))
    xlabel('Time (s)');ylabel('Error (m/s)')
    title('X Axis Velocity Error Plot (True - Estimated)')
end

figure;
subplot(nPlots,1,1);plot(ECEFvel.Time,ECEFvel.Data(:,2)); hold all;
clear legendText
legendText{1} = 'True';
if plotFiltered == 1
    plot(filtECEFvel.Time,filtECEFvel.Data(:,2))
    legendText{end+1} = 'Filtered';
end
if plotEstimated == 1
    plot(estECEFvel.Time,estECEFvel.Data(:,2))
    legendText{end+1} = 'Estimated'; 
end
xlabel('Time (s)');ylabel('Velocity (m/s)'); legend(legendText)
title('Y Axis Velocity ECEF')
n = 1;
if plotFiltered == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(ECEFvel.Time,ECEFvel.Data(:,2)-filtECEFvel.Data(:,2))
    xlabel('Time (s)');ylabel('Error (m/s)')
    title('Y Axis Velocity Error Plot (True - Filtered)')
end
if plotEstimated == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(ECEFvel.Time,ECEFvel.Data(:,2)-estECEFvel.Data(:,2))
    xlabel('Time (s)');ylabel('Error (m/s)')
    title('Y Axis Velocity Error Plot (True - Estimated)')
end


figure;
subplot(nPlots,1,1);plot(EulerAngles.Time,EulerAngles.Data(:,3)*rtd);hold all   ,
clear legendText
legendText{1} = 'True';
if plotFiltered == 1
    plot(filtEulerAngles.Time,filtEulerAngles.Data(:,3)*rtd);
    legendText{end+1} = 'Filtered';
end
if plotEstimated == 1
    plot(estEulerAngles.Time,estEulerAngles.Data(:,3)*rtd)
    legendText{end+1} = 'Estimated';
end
xlabel('Time (s)');ylabel('Theta (deg)');legend(legendText)
title('Angular Position')
n = 1;
if plotFiltered == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(EulerAngles.Time,EulerAngles.Data(:,3)*rtd-filtEulerAngles.Data(:,3)*rtd)
    xlabel('Time (s)');ylabel('Error (deg)')
    title('Angular Position Error Plot (True - Filtered)')
end
if plotEstimated == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(EulerAngles.Time,EulerAngles.Data(:,3)*rtd-estEulerAngles.Data(:,3)*rtd)
    xlabel('Time (s)');ylabel('Error (deg)')
    title('Angular Position Error Plot (True - Estimated)')
end

figure;
subplot(nPlots,1,1);plot(BodyRates.Time,BodyRates.Data(:,3)*rtd);hold all
clear legendText
legendText{1} = 'True';
if plotFiltered == 1
    plot(filtBodyRates.Time,filtBodyRates.Data(:,3)*rtd)
    legendText{end+1} = 'Filtered';
end
if plotEstimated == 1
    plot(estBodyRates.Time,estBodyRates.Data(:,3)*rtd)
    legendText{end+1} = 'Estimated';
end
xlabel('Time (s)');ylabel('Rate (deg/s)');legend(legendText)
title('Angular Rate')
n = 1;
if plotFiltered == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(BodyRates.Time,BodyRates.Data(:,3)*rtd-filtBodyRates.Data(:,3)*rtd)
    xlabel('Time (s)');ylabel('Error (deg/s)')
    title('Angular Rate Error Plot (True - Filtered)')
end
if plotEstimated == 1
    n = n + 1;
    subplot(nPlots,1,n);plot(BodyRates.Time,BodyRates.Data(:,3)*rtd-estBodyRates.Data(:,3)*rtd)
    xlabel('Time (s)');ylabel('Error (deg/s)')
    title('Angular Rate Error Plot (True - Estimated)')
end
