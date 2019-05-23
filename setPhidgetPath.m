
P = py.sys.path;

if count(P,'Z:\My Documents\MATLAB\AirTableSim\Phidget\Phidget_Library_Python') == 0
    insert(P,int32(0),'Z:\My Documents\MATLAB\AirTableSim\Phidget\Phidget_Library_Python');
end

if count(P,'Z:\My Documents\Phidget22Python') == 0
    insert(P,int32(0),'Z:\My Documents\Phidget22Python');
end

if count(P,'Z:\My Documents\Phidget22Python\Phidget22') == 0
    insert(P,int32(0),'Z:\My Documents\Phidget22Python\Phidget22');
end

if count(P,'Z:\My Documents\Phidget22Python\Phidget22\Devices') == 0
    insert(P,int32(0),'Z:\My Documents\Phidget22Python\Phidget22\Devices');
end