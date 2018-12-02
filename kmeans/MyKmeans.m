function [idx,C,sumD,D] = MyKmeans(X,K,C0,numIter)
[X_row,X_column] = size(X);
idx = zeros(X_row,numIter);
sumD = zeros(1,numIter);
C = C0;
D = zeros(X_row,K);
%temp = zeros(X_row,X_column);
for i = 1:numIter
    for j = 1:K
        %temp = repmat(C(j,:),X_row,1);
        D(:,j) = X(:,1).* X(:,1) + C(j,1).* C(j,1) - 2 *  C(j,1).* X(:,1);
        for p = 2:X_column
            D(:,j) = D(:,j) + X(:,p).* X(:,p) + C(j,p).* C(j,p) - 2 *  C(j,p).* X(:,p);
        end
        %D(:,j) = sum(X.*X + temp.*temp - 2 * temp.*X,2);
    end
    [sum_row,idx(:,i)] = min(D,[],2);
    sumD(i) = sum(sum_row);
    if i == numIter
        C = C./repmat(sqrt(sum(C.*C,2)),1,X_column);
        break;
    end
    for r = 1:K
        C_temp = (idx(:,i) == r);
        C(r,:) = sum(X(C_temp,:),1);
    end
    C = C./repmat(sqrt(sum(C.*C,2)),1,X_column);
end
idx = idx';
end