function TestMyKmeans(filename,numRepeat, numIter)
data = importdata(filename); 
Y = data(:,1)+1; 
X = data(:,2:end); 
clear data; 
K = max(Y); 
n = length(Y);
%%%%%% %%% Normalize the data to have unit L2 norm %%%%
X = X./repmat(sqrt(sum(X.*X,2)),1,size(X,2));

SD1 = zeros(numRepeat,numIter); 
for i = 1:numRepeat; 
    i
    C0 = X(randsample(n,K),:); 
    tic;
    [idx1{i},C1,SD1(i,:),D1{i}]=MyKmeans(full(X),K,full(C0),numIter);
    T1(i)=toc;
    tic;
    [idx2{i},C2,sumd2,D2{i}]=kmeans(full(X),K,'Start',full(C0),'Maxiter',numIter); 
    T2(i)=toc;
    SD2(i,:) = sum(sumd2); 
    for t = 1:numIter; 
        acc1(i,t) = 100*evalClust_Error(idx1{i}(t,:),Y);
    end
%%%%%%% %%%% Evluate the classification accuracy for Maltab Kmeans algorithm

%%%%%%%%
end
figure; 
plot(1:numIter,SD1,'linewidth',2);hold on; grid on; 
set(gca,'FontSize',20); xlabel('Iteration');ylabel('SD'); title(filename);

figure; 
%%%%%% %%% Plot accuracies %%%% 
plot(1:numIter,acc1,'linewidth',2);hold on; grid on;
plot(1:numIter,mean(acc1,1),':','linewidth',2);hold on;grid on;
set(gca,'FontSize',20); xlabel('Iteration');ylabel('Accuracy (%)'); title(filename);
figure; 
%%%%%%%% %%%% Plot times %%%%%%%%
plot(T1,T2,'d','linewidth',2);hold on; grid on;
plot(T2,T2,'r','linewidth',2);hold on;grid on;
set(gca,'FontSize',20); xlabel('My Kmeans Time');ylabel('Matlab Kmeans Time'); title(filename);

end

