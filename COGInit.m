function [cog,FM,ulambda,AjInv] = COGInit(thrusterData,nThruster)

% Compute the composite force and moment for each thruster
FM = [thrusterData.thrusterForce(:,1:2) thrusterData.thrusterMoment(:,3)];

% Cost function. Assume all thrusters are equal
cvec = [1 1 1];

% Initialize variables
A=zeros(nThruster,3,3);
Aj=zeros(3,3);
ncog = 0;

C = thrusterData.thrusterCombinations;

% Loop through all thruster combinations
for i = 1:size(C,1)
    for j = 1:3
        if C(i,j) ~= 0
            % Form the A matrix (columns are FM vectors)
            Aj(:,j) = FM(C(i,j),:)';
        end
        
    end
    % Invert the A matrix, if it is singular, this combination
    % is not a COG
    % Check determinant
    if abs(det(Aj)) < 1e-9
        continue
    else
        Ajinv = Aj\eye(size(Aj));
    end
    
    % Form lambda vectors
     lambda = cvec*Ajinv;
%     lambdaTemp = cvec*Ajinv;
%     lambda(1) = sum(Ajinv(1,:));
%     lambda(2) = sum(Ajinv(2,:));
%     lambda(3) = sum(Ajinv(3,:));
%     lambda(1) = sum(Ajinv(:,1));
%     lambda(2) = sum(Ajinv(:,2));
%     lambda(3) = sum(Ajinv(:,3));

    dotResult = 0.0;
    k = 0;
    
    while k < nThruster && dotResult <= 1.0
        k = k+1;
        if k ~= C(i,1) && k ~= C(i,2) && k ~= C(i,3)
            % If the result of the dot product is > 1
            % this combination is not a cog, break out
            % of the loop and move on to the next
            dotResult=dot(lambda,FM(k,:));
            if dotResult > 1.0
                break;
            end
            
        end
    end
    
    if dotResult <= 1.0
        % All thrusters checked, this is a COG
        % Store the thruster indices and unit lambda vector
        ncog = ncog+1;
        cog(ncog,:) = C(i,:);
        lambdaOut(ncog,:) = lambda;
        ulambda(ncog,1) = lambda(1)/norm(FM(C(i,1),:));
        ulambda(ncog,2) = lambda(2)/norm(FM(C(i,2),:));
        ulambda(ncog,3) = lambda(3)/norm(FM(C(i,3),:));
        AjInv(ncog,:,:) = Ajinv;
%         x = FM(C(i,2),:) - FM(C(i,1),:);
%         y = FM(C(i,3),:) - FM(C(i,1),:);
%         z = FM(C(i,3),:) - FM(C(i,2),:);
%         dot(lambda,x)
%         dot(lambda,y)
%         dot(lambda,z)
        
    end
end


% bvec = [-1 -1 -1];
% bvecs = combnk([-1 0 1 -1 0 1 -1 0 1],3);
% ifound = zeros(size(bvecs,1));
% for m = 1:size(bvecs,1)
%     for n = 1:ncog
%         testA = squeeze(AjStore(n,:,:));
%         testAinv = testA\eye(size(testA));
% 
%         xx=sum(testAinv*bvecs(m,:)' >= 0);
% 
%         if xx == 3 && ifound(m) == 0 
%            ifound(m) = 1;
% %            disp(sprintf('Found COG for: %d',bvecs(m)))
%     %         btime = testAinv*bvec';
%     %         cog(n,:)
%     %         tFM = btime(1)*FM(cog(n,1),:) + btime(2)*FM(cog(n,2),:) + btime(3)*FM(cog(n,3),:)
%         end
% 
%     end
%     if ifound(m) == 0
%         disp(sprintf('Could not find COG for %d',m))
%     end
% end

