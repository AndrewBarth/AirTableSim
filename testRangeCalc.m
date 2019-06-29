

state = Simulink.Bus.createMATLABStruct('FullStateBus');
state.TranState_ECEF.R_Sys_ECEF = [1.5 2.0 0]';
state.TranState_ECEF.R_Sys_ECEF = [0.9 1.2 0]';
i=0;
for ang = 0:.01:2*pi
    i=i+1;
    quat=euler2quat([0 0 ang]);
    state.RotState_Body_ECEF.Body_To_ECEF_Quat = quat';
    
    [range,rangeArray] = senseWalls(state,rangeSensorLocBody,rangeSensorAngBody,rangeSensorFOV,wallBounds);
    
    [estPos,fullRange,fullAngle,thirdSide,area] = estimatePosition(range,rangeSensorLocBody,rangeSensorAngBody,wallBounds);
    
    angle(i) = ang;
    oppAng(i,1) = fullAngle(1)+fullAngle(3);
    oppAng(i,2) = fullAngle(2)+fullAngle(4);
    nextAng(i,1) = fullAngle(1)+fullAngle(2);
    nextAng(i,2) = fullAngle(3)+fullAngle(4);
    sides(i,:) = thirdSide;
    totalSides(i) = sum(thirdSide);
    totalarea(i) = area;
    
end
    