
x = 5052.4587;
y = 1056.2713;
z = 5011.6366;

vx = 3.8589872;
vy = 4.2763114;
vz = -4.8070493;

x = -6045;
y = -3490;
z =  2500;

vx = -3.457;
vy =  6.618;
vz =  2.533;

mu = 398600.44;
t = 0;

pos = [x y z]';
vel = [vx vy vz]';

oe = cartesianToOE(t,pos,vel,mu);


[pos2,vel2] = OEToCartesian(t,oe,mu);