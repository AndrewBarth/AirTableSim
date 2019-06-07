function y = imuFilter(u)

persistent inputStates
persistent outputStates

b = [0.2462e-5 0.4924e-5 0.2462e-5];
a = [1.0000   -1.9956    0.9956];

gain = sum(b)/sum(a);
gain=1;
if isempty(inputStates)
    inputStates = [u u u];
end
if isempty(outputStates)
    outputStates = [u u u];
end


order = 2;

% Updtate the input states
inputStates = [u inputStates(1:order)];
inputStates1 = inputStates;
temp = 0;
temp2 = 0;
for k = 1:order+1
    temp = temp + b(k)*inputStates(k);
end
for k = 2:order+1
    temp2 = temp2 + a(k)*outputStates(k-1);
end

y = temp - temp2

% Update the output states
outputStates = [y outputStates(1:order)];
outputStates1 = outputStates