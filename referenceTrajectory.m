function [refTraj] = referenceTrajectory(IC_State)

IC_ECEFpos = IC_State.TranState_ECEF.R_Sys_ECEF;
IC_ECEFvel = IC_State.TranState_ECEF.V_Sys_ECEF;
IC_EulerA = IC_State.RotState_Body_ECEF.Body_To_ECEF_Euler;
IC_Rates = IC_State.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

dtr = pi/180;
cmd = zeros(4,12);
IC       = [IC_ECEFpos' IC_EulerA' IC_ECEFvel' IC_Rates'];
cmd(1,:) = [0.0 0.0 0.0  0.0 0.0 0.0     0.0 0.0 0.0  0.0 0.0 0.0];
cmd(2,:) = [2.0 1.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0];
cmd(3,:) = [2.0 1.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0];
cmd(4,:) = [2.0 1.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0];
% cmd(5,:) = [2.0 1.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0];


timeline = [0 20 25 45];

refTraj = [timeline(1) IC; ...
           timeline(2) cmd(2,:); ...
           timeline(3) cmd(3,:); ...
           timeline(4) cmd(4,:)];



