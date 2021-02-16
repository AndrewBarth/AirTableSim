function [xNew] = intState(dt,step,x,F,u,m,J)


phi = eye(9,9) + F*step + (F*step)^2/2;
G = [step^2/(2*m) step^2/(2*m) step^2/(2*J) step/m step/m step/J 1/m 1/m 1/J]';

t = 0;
while t <= (dt-0.0001)
    x = phi*x + (G.*u);
    
    t = t + step;
end
xNew = x;
