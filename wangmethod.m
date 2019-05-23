


loadThrusterData;
m=3;
n=nThruster;

A = FM';
c = [1 1 1 1 1 1 1 1];
Abar = [FM' eye(m,m)];

M=500;
for j = 1:nThruster
    c0(j) = c(j) - M*sum(A(1:m,j));
end
cbar = [c0 zeros(1,m)];

u = [1 0 1];
tableau(1,:) = [1 cbar 0];
tableau(2,:) = [0 Abar(1,:) u(1)];
tableau(3,:) = [0 Abar(2,:) u(2)];
tableau(4,:) = [0 Abar(3,:) u(3)];

% Determine entering variable
[val pCol] = min(tableau(1,:));

% Determine all possible leaving variables
[leave] = tableau(2:4,pCol) > 0;



% Loop through all pivot rows
for pRow=2:2
    if leave(pRow-1) == 1
        % This is a leaving variable
        
        % Perform Jordan row operaptions 
        [newTableau] = jordanRowOps(tableau,pRow,pCol,m);

    end
end
    
    
