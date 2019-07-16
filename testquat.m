
euler = [ 0 0 30*pi/180];

q0 = cos(euler(3)/2)*cos(euler(2)/2)*cos(euler(1)/2) + sin(euler(3)/2)*sin(euler(2)/2)*sin(euler(1)/2);
q1 = cos(euler(3)/2)*cos(euler(2)/2)*sin(euler(1)/2) - sin(euler(3)/2)*sin(euler(2)/2)*cos(euler(1)/2);
q2 = cos(euler(3)/2)*sin(euler(2)/2)*cos(euler(1)/2) + sin(euler(3)/2)*cos(euler(2)/2)*sin(euler(1)/2);
q3 = sin(euler(3)/2)*cos(euler(2)/2)*cos(euler(1)/2) - cos(euler(3)/2)*sin(euler(2)/2)*sin(euler(1)/2);

qa = [q0 q1 q2 q3];


q3 = [cos(euler(3)/2) 0 0 sin(euler(3)/2)];
q2 = [cos(euler(2)/2) 0 sin(euler(2)/2) 0];
q1 = [cos(euler(1)/2) sin(euler(1)/2) 0 0];

% Compute output q = q3*q2*q1
q21  = quatmult(q2,q1);
q321 = quatmult(q3,q21);
qb = q321;


q32 = quatmult(q3,q2);
q321 = quatmult(q32,q1);
qc = q321;

dcma = EulerToDCM_321(euler);
dcmb = quatToDCM(qa);