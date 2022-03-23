function [outGNCMode] = gncExecutive(navState,refTraj,useRangeGuid,inGNCMode)
% Determine when the proper location and orientation has been reached
% and proceed with the approach
% 
% Inputs: navState        current state data
%         refTraj         reference trajectory 
%         useRangeGuid    Flag (0 or 1) to indicate if range guidance
%                         should be used
%         inGNCMode       current GNC mode
%
% Output: outGNCMode  desired GNC mode
%
% Assumptions and Limitations:
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Jun 19 2019 - Initial version
%    Mar 23 2022 - Renamed and modified final approach logic
%

% Default is to remain in current mode
outGNCMode = inGNCMode;

% Define tolerances for transition to ranging guidance
RG_PosTol = 0.03;
RG_VelTol = 0.04;
RG_AttTol = 0.075;  % 1 deg
RG_RateTol = 0.075; % 1 deg/s

pos = navState.TranState_ECEF.R_Sys_ECEF';
vel = navState.TranState_ECEF.V_Sys_ECEF';
att = navState.RotState_Body_ECEF.ECEF_To_Body_Euler';
rate = navState.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body';

refPos  = refTraj(end,2:4);
refVel  = refTraj(end,8:10);
refAtt  = refTraj(end,5:7);
refRate = refTraj(end,11:13);

posErr = norm(refPos - pos);
velErr = norm(refVel - vel);
attErr = norm(refAtt - att);
rateErr = norm(refRate - rate);

if inGNCMode ~= 2
    if useRangeGuid > 0 && posErr < RG_PosTol && velErr < RG_VelTol && attErr < RG_AttTol && rateErr < RG_RateTol
        % Switch to range guidance mode
        outGNCMode = 2;
    end
end
