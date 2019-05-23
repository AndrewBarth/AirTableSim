

for i=1:size(controlMoment.Time,1)
    dotResult(i) = dot(controlMoment.Data(i,:)/norm(controlMoment.Data(i,:)),thrusterOut.Data(i,:)/norm(controlMoment.Data(i,:)));
end