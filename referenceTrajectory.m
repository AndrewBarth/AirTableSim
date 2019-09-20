function [refTraj] = referenceTrajectory(IC_State,refIdx,PositionData,rawPosition,RotationData)

dtr = pi/180;
cmd = zeros(6,15);

IC_ECEFpos = IC_State.TranState_ECEF.R_Sys_ECEF;
IC_ECEFvel = IC_State.TranState_ECEF.V_Sys_ECEF;
IC_EulerA = IC_State.RotState_Body_ECEF.ECEF_To_Body_Euler;
IC_Rates = IC_State.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;
IC       = [IC_ECEFpos' IC_EulerA' IC_ECEFvel' IC_Rates' 0 0 0];

if norm(rawPosition) > eps
    nav_ECEFpos = PositionData;
else
    nav_ECEFpos = IC_ECEFpos;
end

if norm(RotationData) > eps
    nav_EulerA = RotationData;
else
    nav_EulerA = IC_EulerA;
end

if refIdx == 0
%     cmd(1,:) = IC;
%     cmd(2,:) = IC;
%     cmd(3,:) = [1.0 2.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0 0];
%     cmd(4,:) = [1.0 2.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0 0];
%     cmd(5,:) = [1.0 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1 1.0-0.45];
%     cmd(6,:) = [1.0 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1 0.25];
%     cmd(1,:) = IC;
%     cmd(2,:) = IC;
%     cmd(3,:) = [1.0 1.5 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0 0];
%     cmd(4,:) = [1.0 1.5 0.0  0.0 0.0 70*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0 0];
%     cmd(5,:) = [1.0 2.0 0.0  0.0 0.0 80*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1 1.0-0.45];
%     cmd(6,:) = [1.0 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1 0.25];
%     cmd(1,:) = IC;
%     cmd(2,:) = IC;
%     cmd(3,:) = [1.0 1.5 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0 0];
%     cmd(4,:) = [1.0 1.5 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0 0];
%     cmd(5,:) = [1.0 1.5 0.0  0.0 0.0 60*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1 1.0-0.45];
%     cmd(6,:) = [1.0 1.5 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1 0.25];
    cmd(1,:) = IC;
    cmd(2,:) = IC;
    cmd(3,:) = [1.0 1.5 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0 0];
    cmd(4,:) = [1.0 1.5 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0 0];
    cmd(5,:) = [1.0 1.5 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1 1.0-0.45];
    cmd(6,:) = [1.0 1.5 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1 0.25];
elseif refIdx == 1
    cmd(1,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0      0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(2,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0      0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(3,:) = [nav_ECEFpos(1)+0.5 nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(4,:) = [nav_ECEFpos(1)+0.5 nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(5,:) = [nav_ECEFpos(1)+0.5 nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(6,:) = [nav_ECEFpos(1)+0.5 nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
elseif refIdx == 2
    cmd(1,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0      0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(2,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0      0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(3,:) = [nav_ECEFpos(1)-0.5 nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(4,:) = [nav_ECEFpos(1)-0.5 nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(5,:) = [nav_ECEFpos(1)-0.5 nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(6,:) = [nav_ECEFpos(1)-0.5 nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
elseif refIdx == 3
    cmd(1,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0      0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(2,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0      0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(3,:) = [nav_ECEFpos(1) nav_ECEFpos(2)+0.5 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(4,:) = [nav_ECEFpos(1) nav_ECEFpos(2)+0.5 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(5,:) = [nav_ECEFpos(1) nav_ECEFpos(2)+0.5 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(6,:) = [nav_ECEFpos(1) nav_ECEFpos(2)+0.5 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
elseif refIdx == 4
    cmd(1,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0      0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(2,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0      0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(3,:) = [nav_ECEFpos(1) nav_ECEFpos(2)-0.5 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(4,:) = [nav_ECEFpos(1) nav_ECEFpos(2)-0.5 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(5,:) = [nav_ECEFpos(1) nav_ECEFpos(2)-0.5 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(6,:) = [nav_ECEFpos(1) nav_ECEFpos(2)-0.5 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
elseif refIdx == 5
    cmd(1,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0  0 1 0];
    cmd(2,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0  0 1 0];
    cmd(3,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 IC_EulerA(3)+90*dtr  0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(4,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 IC_EulerA(3)+90*dtr  0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(5,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 IC_EulerA(3)+90*dtr  0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(6,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 IC_EulerA(3)+90*dtr  0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
elseif refIdx == 6
    cmd(1,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0  0 1 0];
    cmd(2,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 nav_EulerA(3) 0.0 0.0 0.0  0.0 0.0 0.0  0 1 0];
    cmd(3,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 IC_EulerA(3)-90*dtr  0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(4,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 IC_EulerA(3)-90*dtr  0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(5,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 IC_EulerA(3)-90*dtr  0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
    cmd(6,:) = [nav_ECEFpos(1) nav_ECEFpos(2) 0.0  0.0 0.0 IC_EulerA(3)-90*dtr  0.0 0.0 0.0  0.0 0.0 0.0    0 1 0];
end


timeline = [0 1.5 30 35 55 70];

refTraj = [timeline(1) cmd(1,:); ...
           timeline(2) cmd(2,:); ...
           timeline(3) cmd(3,:); ...
           timeline(4) cmd(4,:); ...
           timeline(5) cmd(5,:); ...
           timeline(6) cmd(6,:)];



