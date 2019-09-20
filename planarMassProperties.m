function [m,Izz] = planarMassProperties()
% Define mass properties for the test artical
%
% Inputs: none
%
% Output: m       mass (kg)
%         Izz     moment of inertia (kg-m^2)
%
% Assumptions and Limitations:
%    Assumes body is a solid regular rectangular prism and rotation is
%    about the z body axis.
%    Assumes no mass loss
%
% References:
% (none)
%
% Author: Andrew Barth
%
% Modification History:
%    Dec 26 2018 - Initial version
%

in2m = 0.0254;

% m = [11.4]; 
m = [19.0]; 

% Dimensions of sled
width = 18*in2m;
depth = 18*in2m;
height = 6.5*in2m;

% Inertia of solid cube
Izz = 1/12 * m * (width^2 + depth^2);