% void rcs_phase_plane(                          /* RETURN: --   Return nothing */
%    double          state_err,                  /* IN:     --   State Error (Actual - Desired) */
%    double          rate_err,                   /* IN:     --   Rate Error (Actual - Desired) */
%    double          max_accel_line_db,          /* IN:     --   Maximum Acceleration Line Deadband */
%    double          drift_zone_line_db,         /* IN:     --   Drift Zone Line Deadband */
%    double          max_accel_slope,            /* IN:     --   Maximum Acceleration Slope */
%    double          drift_zone_slope,           /* IN:     --   Drift Zone Slope */
%    double          max_cmd,                    /* IN:     --   Maximum Output Command */
%    double          min_cmd,                    /* IN:     --   Minimum Output Command */
%    double          drift_channel_rate,         /* IN:     --   Drift Channel Rate */
%    double          drift_channel_width,        /* IN:     --   Drift Channel Width */
%    double          step_width,                 /* IN:     --   Width of step inside Maximum Acceleration Zone */
%    double          *rate_err_out,              /* OUT:    --   Output Rate Error */
%    double          *state_err_out,             /* OUT:    --   Output State Error */
%    double          *cmd_out)                   /* OUT:    --   Output Command (Frame is same as input errors) */

function [cmdOut] = phasePlaneControl(att_err,rate_err,drift_channel_db,drift_channel_rate, ...
                                      drift_channel_width, max_cmd)
                                                                
% Function to model a set of thrusters
% 
% Inputs: att_err             attitude error (rad)
%         rate_err            rate error (rad/s)
%         drift_channel_db    attitude deadband to enter/exit the drift channel (rad)
%         drift_channel_rate  rate boundary for maneuver channel (rad/s)
%         drift_channel_width width of the drift channel (rad/s)
%         max_cmd             value for the output command 
%
% Output: cmdOut              output control command
%
% Assumptions and Limitations:
%
% Dependencies:
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Dec 06 2021 - Initial version
%


    % First check to see if the state is one of the horizontal drift channels on
    % either the left or right side of the phase plane
    if att_err > drift_channel_db
        % Right side of drift channel
        if rate_err > -drift_channel_rate
            % Command negative firing to enter the drift channel
            cmdOut = -max_cmd;
        elseif rate_err < (-drift_channel_rate - drift_channel_width)
            % Command positive firing to enter the drift channel
            cmdOut = max_cmd;
        else
            % In the drift channel
            cmdOut = 0.0;
        end
    elseif att_err < -drift_channel_db
        % Left side of drift channel
        if rate_err < drift_channel_rate
            % Command positive firing to enter the drift channel
            cmdOut = max_cmd;
        elseif rate_err > (drift_channel_rate + drift_channel_width)
            % Command negative firing to enter the drift channel
            cmdOut = -max_cmd;
        else
            % In the drift channel
            cmdOut = 0.0;
        end
    else
        % In the central dead zone
        % compute the deadzone slope
        deadzone_slope = (2*drift_channel_rate + drift_channel_width) / (2*drift_channel_db);
%         top_line = -drift_channel_rate + (att_err - drift_channel_db)*deadzone_slope;
%         bottom_line = (-drift_channel_rate - drift_channel_width) + (att_err - drift_channel_db)*deadzone_slope;
        top_line = (drift_channel_db - att_err)*deadzone_slope + (-1*drift_channel_rate);
        bottom_line = top_line - drift_channel_width;
        if rate_err > top_line
            % Command negative firing to enter the drift channel
            cmdOut = -max_cmd;
        elseif rate_err < bottom_line
            % Command positive firing to enter the drift channel
            cmdOut = max_cmd;
        else
            % In the drift channel
            cmdOut = 0.0;
        end
    end
            
% Declare internal variables
%    double right_max_accel_line;
%    double left_max_accel_line;
%    double right_drift_zone_line;
%    double left_drift_zone_line;

%    % Initialize outputs
%    cmdOut = 0;
%    stateErrOut = 0;
%    rateErrOut = 0;
% 
%    % Calculate Boundary Lines
%    right_max_accel_line  = max_accel_slope * (state_err - max_accel_line_db);
%    left_max_accel_line   = max_accel_slope * (state_err + max_accel_line_db);
%    right_drift_zone_line = drift_zone_slope * (state_err - drift_zone_line_db);
%    left_drift_zone_line  = drift_zone_slope * (state_err + drift_zone_line_db);
% 
%    % Check if inside Negative Accel Maximum Command Zone
%    if (rate_err > (drift_channel_rate + drift_channel_width) || ...
%        ((rate_err > right_max_accel_line) && (rate_err > (-drift_channel_rate + drift_channel_width))))
%       if ((state_err < (max_accel_line_db + step_width)) && (rate_err > right_max_accel_line))
%          if (rate_err < (max_cmd - (0.5 * min_cmd)))
%             if (rate_err < (0.5 * min_cmd))
%                if (rate_err < 0) 
% 
%                   %Negative Accel Drift Zone */
%                   cmdOut = 0;
%                   stateErrOut = 0;
%                   rateErrOut = 0;
%                  
%                else
% 
%                   % Negative Accel Minimum Command Zone */
%                   cmdOut = -min_cmd;
%                   stateErrOut = 0;
%                   rateErrOut = 0;
%                   return;
%                end               
%             else
% 
%                % Negative Accel Target Zone *
%                cmdOut = -min_cmd - rate_err;
%                stateErrOut = 0;
%                rateErrOut = 0;
%                return;
%             end            
%          else
% 
%             % Negative Accel Maximum Command Zone */
%             cmdOut = -max_cmd;
%             stateErrOut = 0;
%             rateErrOut = 0;
%             return;
%          end
%       else
% 
%          % Negative Accel Maximum Command Zone */
%          cmdOut = -max_cmd;
%          stateErrOut = 0;
%          rateErrOut = 0;
%          return;
%       end
% 
%       return; 
%    end
% 
%    % Check if inside Positive Accel Maximum Command Zone 
%    if (rate_err < (-drift_channel_rate - drift_channel_width) || ...
%        ((rate_err < left_max_accel_line) && (rate_err < (drift_channel_rate - drift_channel_width)))) 
%       if ((state_err > -(max_accel_line_db + step_width)) && (rate_err < left_max_accel_line)) 
%          if (rate_err > -(max_cmd - (0.5 * min_cmd))) 
%             if (rate_err > -(0.5 * min_cmd)) 
%                if (rate_err > 0) 
% 
%                   % Positive Accel Drift Zone */
%                   cmdOut = 0;
%                   stateErrOut = 0;
%                   rateErrOut = 0;
%                   return;
%                else
% 
%                   % Positive Accel Minimum Command Zone */
%                   cmdOut = min_cmd;
%                   stateErrOut = 0;
%                   rateErrOut = 0;
%                   return;
%                end
%             else
% 
%                % Positive Accel Target Zone */
%                cmdOut = min_cmd - rate_err;
%                stateErrOut = 0;
%                rateErrOut = 0;
%                return;
%             end
%          else
% 
%             % Positive Accel Maximum Command Zone */
%             cmdOut = max_cmd;
%             stateErrOut = 0;
%             rateErrOut = 0;
%             return;
%          end
%       else
% 
%          % Positive Accel Maximum Command Zone */
%          cmdOut = max_cmd;
%          stateErrOut = 0;
%          rateErrOut = 0;
%          return;
%       end
% 
%       return;
%    end
% 
%    % Check if inside Negative Accel Linear Zone */
%    if ((rate_err < right_max_accel_line) && ...
%        (rate_err > right_drift_zone_line) && ...
%        (rate_err > (-drift_channel_rate + drift_channel_width)) && ...
%        (rate_err < (drift_channel_rate + drift_channel_width))) 
% 
%       % Negative Accel Linear Zone */
%       cmdOut = 0;
%       stateErrOut = state_err;
%       rateErrOut  = rate_err;
%       return;
%    end
% 
%    % Check if inside Positive Accel Linear Zone */
%    if ((rate_err > left_max_accel_line) && ...
%        (rate_err < left_drift_zone_line) && ...
%        (rate_err < (drift_channel_rate - drift_channel_width)) && ...
%        (rate_err > (-drift_channel_rate - drift_channel_width)))
% 
%       % Positive Accel Linear Zone */
%       cmdOut = 0;
%       stateErrOut = state_err;
%       rateErrOut  = rate_err;
%       return;
%    end
% 
%    % Check if inside Positive Rate Drift Channel */
%    if ((rate_err < right_drift_zone_line) && ...
%        (rate_err < (drift_channel_rate + drift_channel_width)) && ...
%        (rate_err > (drift_channel_rate - drift_channel_width)))
% 
%       % Positive Rate Drift Channel */
%       cmdOut = 0;
%       stateErrOut = state_err;
%       rateErrOut  = rate_err;
%       return;
%    end
% 
%    % Check if inside Negative Rate Drift Channel */
%    if ((rate_err > left_drift_zone_line) && ...
%        (rate_err > (-drift_channel_rate - drift_channel_width)) && ...
%        (rate_err < (-drift_channel_rate + drift_channel_width)))
% 
%       % Negative Rate Drift Channel */
%       cmdOut = 0;
%       stateErrOut = 0;
%       rateErrOut = 0;
%       return;
%    end
% 
%    % Check if inside Drift Zone */
%    if ((rate_err > left_drift_zone_line) && ...
%        (rate_err < right_drift_zone_line) && ...
%        (rate_err > (-drift_channel_rate + drift_channel_width)) && ...
%        (rate_err < (drift_channel_rate - drift_channel_width)))
% 
%       % Drift Zone */
%       cmdOut = 0;
%       stateErrOut = 0;
%       rateErrOut = 0; 
%       return;
%    end
% end
