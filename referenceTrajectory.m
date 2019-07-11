function [refTraj] = referenceTrajectory(IC_State)

IC_ECEFpos = IC_State.TranState_ECEF.R_Sys_ECEF;
IC_ECEFvel = IC_State.TranState_ECEF.V_Sys_ECEF;
IC_EulerA = IC_State.RotState_Body_ECEF.ECEF_To_Body_Euler;
IC_Rates = IC_State.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;

dtr = pi/180;
cmd = zeros(5,14);
IC       = [IC_ECEFpos' IC_EulerA' IC_ECEFvel' IC_Rates' 0 0];
cmd(1,:) = [0.0 0.0 0.0  0.0 0.0 0.0     0.0 0.0 0.0  0.0 0.0 0.0  0 0];
cmd(2,:) = [1.5 2.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0];
cmd(3,:) = [1.5 2.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0];
cmd(4,:) = [1.5 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 1.0-0.45];
cmd(5,:) = [1.5 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 0.25];

% IC       = [IC_ECEFpos' IC_EulerA' IC_ECEFvel' IC_Rates' 0 0];
% cmd(1,:) = [0.0 0.0 0.0  0.0 0.0 0.0     0.0 0.0 0.0  0.0 0.0 0.0  0 0];
% cmd(2,:) = [1.5 2.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0];
% cmd(3,:) = [1.5 2.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0];
% cmd(4,:) = [1.5 2.0 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 0.25];
% cmd(5,:) = [1.5 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0 0 0];

% IC       = [IC_ECEFpos' IC_EulerA' IC_ECEFvel' IC_Rates' 0 0];
% cmd(1,:) = [0.0 0.0 0.0  0.0 0.0 0.0     0.0 0.0 0.0  0.0 0.0 0.0  0 0];
% cmd(2,:) = [0.5 2.0 0.0  0.0 0.0 0*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0];
% cmd(3,:) = [0.5 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  0 0];
% cmd(4,:) = [0.5 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0  1 0.25];
% cmd(5,:) = [1.5 2.0 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0 0 0];

timeline = [0 3 20 25 45 60];



refTraj = [timeline(1) IC; ...
           timeline(2) IC; ...
           timeline(3) cmd(2,:); ...
           timeline(4) cmd(3,:); ...
           timeline(5) cmd(4,:); ...
           timeline(6) cmd(5,:)];



