function IIR_Output = eml_IIR_Filter(Input , Data_Quality , IIR_Numerator , IIR_Denominator , Init)     %#eml

%--------------------------------------------------------------------------
% Function Name: eml_IIR_Filter
%--------------------------------------------------------------------------
% Description:
%   This function will implement a Nth order Infinite-Impulse-Response 
%   (IIR) filter.  It can complete this for inputs of any number of axes
%   [NA], any data-type, any number of filter states [NFS], and any number
%   of samples [NS] (such as 3x6 IMU packets, or individual 1x1 single 
%   samples).  The Init input enables the filter to be re-initialized such 
%   that the filter states and output states are re-set as if the most
%   recent sample had been executed for an infinite period of time. Note
%   that the re-initialization logic will be run on each execution cycle
%   until non-failed sample data is received.
%--------------------------------------------------------------------------
% Abbreviation Key:
%   [NS]    > # of Samples          (Ex: 6 for a 3x6 IMU packet)
%   [NFS]   > # of Filter States    (Ex: 5 for a 4th order filter)
%   [NA]    > # of Axes             (Ex: typically 3, for 3x6 IMU Packets)
%   
% Inputs:
%   Input           > [NAxNS] Packets of Accels or Rates; 1st column is the
%                             oldest data
%   Data_Quality    > [1xNS]  0 = Undetermined
%                             1 = Good
%                             2 = Suspect
%                             3 = Fail
%   IIR_Numerator   > [1xNFS] Numerator coefficients of the IIR Filter
%   IIR_Denominator > [1xNFS] Denominator coefficients of the IIR Filter
%   Init            > [1] Flag to (re)initialize the filter
%
% Outputs:
%   IIR_Output      > [NA] The filtered output of the IMU packets
%--------------------------------------------------------------------------
% Assumptions and Limitations:
%   1)  The denominator's first coefficient will not be zero (should 
%       typically be 1 or close to 1 to correct for OIMU scale-factor errors)
%   2)  sum(IIR_Denominator) does not equal 0.  This is used to inialize
%       the output states of the filter.
%   3)  The the "i-th" Data_Quality indicator is 0, then all 'j-th' data
%       quality indicators are also 0 for j>i.
%--------------------------------------------------------------------------
% Created / Modified By:
%   14 Nov 2011    David Shoemaker   david.m.shoemaker@lmco.com, 303.971.5087
%   6 December 2011 David Shoemaker  david.m.shoemaker@lmco.com, 303.971.5087
%       * Updated to include both Good AND Suspect data
%       * Updated to initialize output to the last frame's data instead of
%         0 for the cases in which we get all BAD data
%   21 December 2011 Jastesh Sud     jastesh.sud@lmco.com, 303-971-5826
%       * Updated logic to only exclude "Fail (3)" Data_Quality, i.e.
%       Undetermined, Suspect or Pass measurements are filtered
%   23 March 2012 Jastesh Sud jastesh.sud@lmco.com, 303-971-5826
%       * Using FMTK_FDIR_FaultEnum instead of pure integer values for Data
%       Quality
%   19 April 2012 Jastesh Sud jastesh.sud@lmco.com, 303-971-5826
%       * Updated initialization method to accept everything except for
%       FAILED measurements. 
%   22 June 2012  David Shoemaker  david.m.shoemaker@lmco.com, 303.971.5087
%       * Updated to check for initialization based on the re-init being
%         held until a non-failed data quality sample comes in. Otherwise,
%         the filter states could be initialized with 0s
%--------------------------------------------------------------------------

eml.inline('never');

%--------------------------------------------------------------------------
% Defining Persistent Data
%--------------------------------------------------------------------------
persistent IIR_States       % [NA x NFS]    The sample input states
persistent IIR_Out_States   % [NA x NFS-1]  The filter output states
persistent IIR_Init_Persist % [1] An element that latches the re-initialization until a non-failed sample is received

% Defining the memory sizes (auto-coder optimizer should in-line these values)
Num_Axes = size(Input,1);           % [NA] Number of axes to filter
Num_Samples = size(Input,2);        % [NS] Number of samples in the input data (i.e. 6 for a 200 Hz IMU Packet)
Num_States = size(IIR_Numerator,2); % [NFS]The number of states is the length of the coefficients (i.e. Filter Order + 1)

%--------------------------------------------------------------------------
% Ensuring Proper Initialization
%--------------------------------------------------------------------------

% Initialize the filter states
% Initialize all states to zero for the first pass, to also cover for the 
% event that Data_Quality is all zeros & make data type consistent w/ Input
if isempty(IIR_States)
    IIR_States = zeros(Num_Axes,Num_States,class(Input));          % Datatype is determined by RTW
    IIR_Out_States = zeros(Num_Axes,Num_States-1,class(Input));    % Datatype is determined by RTW
    IIR_Init_Persist = true;
end

% Assigning the IIR Initialization Persistent element
if Init     % Then re-initialize
    IIR_Init_Persist = true;
end     % Otherwise hold last value

% Initialization Logic
if IIR_Init_Persist
    
    % Initialize the IIR States to the latest sample & the outputs states to the DC gain of the filter
    for ind_col =  uint32(Num_Samples:-1:1)   % Most recent sample is in column 6
        
        if Data_Quality(1,ind_col) ~= 0   % then it's a valid sample
            
            for ind_axis = uint32(1:Num_Axes)
                IIR_States(ind_axis,1:Num_States) = Input(ind_axis,ind_col);  % Set all N states to the latest sample
                IIR_Out_States(ind_axis,1:Num_States-1) = ...  % Set all N Output states the latest sample
                    1 * Input(ind_axis,ind_col);
%                     sum(IIR_Numerator(1,:))/sum(IIR_Denominator(1,:)) * Input(ind_axis,ind_col);
                % Note that it's assumed that the IIR_Denominator sum does
                % not equal 1 through the configuration data check
            end
            
            IIR_Init_Persist = false;   % Non-Failed data enabled initialization
            break;  % Filter initialized, don't need to look for more latent data
        end
        
    end     % end of finding the column of latest data
    % NOTE: If no non-failed samples were found, the IIR_States and
    %       IIR_Out_States are held from the previous cycle and this logic
    %       will be re-evalauted on the next cycle
    
end     % end of initializing data


%--------------------------------------------------------------------------
% Completing 2nd Order Filter
%--------------------------------------------------------------------------
% Initalizing the outputs to the same data type as the IMU Packet and to
% the values computed from the last frame. This will therefore output the
% last frame's stale data if the current data is FAILED
IIR_Output = IIR_Out_States(:,1);

% Complete the filtering on a per-valid sample basis
for ind_col = uint8(1:Num_Samples)
    
    % Check to see if the column of data is invalid
    if (Data_Quality(1,ind_col) == 0)  %Measurement is Failed
        break;  % exist the loop; no more samples to filter
    end
    
    % Filtering each axis
    for ind_axis = uint8(1:Num_Axes)   % 3-DOF
        % Update the IIR Filter States; Note that this order is the first
        % column is the most recent sample (classical form, opposite of
        % Input).
        IIR_States(ind_axis,:) = [Input(ind_axis,ind_col) , IIR_States(ind_axis,1:end-1)];
        IIR_States2 = IIR_States;
        %  Completing the filtering
        IIR_Output(ind_axis) = 1/IIR_Denominator(1,1) * (...
            IIR_Numerator(1,:)*IIR_States(ind_axis,:)' - ...
            IIR_Denominator(1,2:end)*IIR_Out_States(ind_axis,:)' )
        
    end     % End of 6 possible new 200 Hz Samples
    
    % Update the output states for the next iteration
    IIR_Out_States = [IIR_Output , IIR_Out_States(:,1:end-1)];
    IIR_Out_States1 = IIR_Out_States
end