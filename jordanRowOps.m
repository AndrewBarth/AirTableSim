function [newTableau] = jordanRowOps(tableau,pRow,pCol,m)

    % Compute new pivot row and zrow
    pElement = tableau(pRow,pCol);
    newTableau(pRow,:) = tableau(pRow,:) / pElement;
    newTableau(1,:) = tableau(1,:) - tableau(pCol)*newTableau(pRow,:);

    % Compute all other rows
    for i = 2:m+1
        if i ~= pRow
            newTableau(i,:) = tableau(i,:) - tableau(i,pCol)*newTableau(pRow,:);
        end
    end
    
end