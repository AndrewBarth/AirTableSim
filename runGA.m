function [pop,fit,exitflag,output,population,scores] = runGA()
% Setup and run the GA function
% 
% Inputs: controlFlag indicates type of control requested
%         ICidx       IC case to run
%         moBotData   structure with robot, rod, and room info
%
% Output: pop         the best individual
%         fit         the best fitness value
%         exitflag    condition that caused the ga to terminate
%         output      output structure of the ga
%         population  the population for the last generation
%         scores      the scores for the last generation
%
% Assumptions and Limitations:
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Apr 20 2019 - Initial version
%    May  6 2019 - Reduced number of variables
%

controlType = 1;

% Number of variables in the population
if controlType == 1
    nvar = 9;
else
    nvar = 9;
end

popSize = 50;
nGen = 10;

dtr = pi/180;


PopulationLB = [zeros(1,7)];
if controlType == 1
    PopulationLB = [zeros(1,9)];
    PopulationUB = [10*ones(1,6) 5 5 5];
else
    PopulationLB = [zeros(1,9)];
    PopulationUB = [1000 1000 100 1000 1000 100 1000 1000 100];
end

% Set up initial values
if controlType == 1
%     a = 2;
%     b = 2;
%     c = 2;
%     gammaA = 2;
%     gammaB = 2;
%     gammaC = 4;
%     epsilonA = 1.0;
%     epsilonB = 1.0;
%     epsilonC = 1.0;
%     X0 = [a b c gammaA gammaB gammaC epsilonA epsilonB epsilonC];
    X0 = [4.6046    0.4443    7.5049    2.0947    2.2831    6.9779    1.9049 1.9049 1.9049];
else
    xKp = [500 500 20];
    xKd = [500 500 8];
    xKi = [0 0 0];
    X0 = [xKp xKd xKi];
end

% Set up the GA
% options = gaoptimset('Generations',nGen,'PopulationSize',popSize,'StallGenLimit',50,'InitialPopulation',X0, ...
%                      'Display','iter','PlotFcn',{@gaplotbestf,@gaplotrange,@gaplotdistance},'UseParallel', true);

options = gaoptimset('Generations',nGen,'PopulationSize',popSize,'StallGenLimit',50,'InitialPopulation',X0, ...
                     'Display','iter','PlotFcn',{@gaplotbestf,@gaplotrange,@gaplotdistance},'UseParallel', false);
                 
% The fitness function will create a FLS and run the sim
FitnessFcn = @(x) executeSim(x,controlType);

% Call the GA
[pop,fit,exitflag,output,population,scores] = ga(FitnessFcn,nvar,[],[],[],[],PopulationLB,PopulationUB,[],[],options);


