function [err, loglik,  err_t] = FitMultiLogit(X,Y,Xt,Yt,numIter,v,lam)
K = max(Y);
beta = zeros(size(X,2),K);
temp = repmat(1:K,size(X,1),1);
r_k = (repmat(Y,1,10) == temp);
loglik = zeros(numIter,1);
err = zeros(numIter,1);
err_t = zeros(numIter,1);
for i = 1:numIter
    i
    for m = 1:size(X,1)
        deno = 0;
        for j = 1:K
            deno = deno + exp(X(m,:)*beta(:,j)); 
        end
        for j = 1:K
            pik(m,j) = exp(X(m,:)*beta(:,j)) / deno; 
        end
    end
    for jj = 1:K
        wk = spdiags(pik(:,jj) - pik(:,jj).*pik(:,jj),0,size(X,1),size(X,1));
        beta(:,jj) = beta(:,jj) + v*((X' * wk * X + lam * diag(ones(size(X,2),1)))...
                     \(X'*(r_k(:,jj) - pik(:,jj)) - lam*beta(:,jj)));
    end
    loglik(i) =  sum(sum(r_k.*log(pik)));
    [val,ind] = max(pik,[],2);
    err(i) = sum(ind == Y) / size(Y,1);
    for mm = 1:size(Xt,1)
        deno = 0;
        for j = 1:K
            deno = deno + exp(Xt(mm,:)*beta(:,j)); 
        end
        for j = 1:K
            pikt(mm,j) = exp(Xt(mm,:)*beta(:,j)) / deno; 
        end
    end
    [val,ind] = max(pikt,[],2);
    err_t(i) = sum(ind == Yt) / size(Yt,1);
end
end