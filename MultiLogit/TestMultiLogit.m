function TestMultiLogit(v,Lam,numIter)
data = feval('load','zip.train'); 
X = data(:,2:end); 
Y = data(:,1)+1; 
X = [X(:,1)*0+1 X];
data = feval('load','zip.test'); 
Xt = data(:,2:end); 
Yt = data(:,1)+1; 
Xt = [Xt(:,1)*0+1 Xt];
m = 1:numIter;
c = colormap(jet(size(Lam,2)));
c_ind = 1;
for lam = Lam 
    tic;
    [err, loglik, err_t] = FitMultiLogit(X,Y,Xt,Yt,numIter,v,lam);
    toc
    figure(1);
    plot(m,loglik,'color',c(c_ind,:),'linewidth',5); hold on; grid on;
    set(gca,'FontSize',20); xlabel('Iteration');ylabel('Log Likelihood'); 
    set(gca,'YLim',[-15000 1000]);
    set(gca,'XTick',0:20:numIter);
    set(gca,'XLim',[0 numIter]);
    title(['Train Log Likelihood: v = ' num2str(v)]);
    text(numIter+1,loglik(end),['\lambda =' num2str(lam)],'Color','k','FontSize',10);
    figure(2);
    plot(m,100 - 100*err,'color',c(c_ind,:),'linewidth',5); hold on; grid on;
    set(gca,'FontSize',20); xlabel('Iteration');ylabel('Mis-Classification Error (%)'); 
    set(gca,'YLim',[0 16]);
    set(gca,'XTick',0:20:numIter);
    set(gca,'XLim',[0 numIter]);
    title(['Train Mis-Classification Error: v = ' num2str(v)]);
    text(numIter+1,100 - 100*err(end),['\lambda =' num2str(lam)],'Color','k','FontSize',10);
    figure(3);
    plot(m,100 - 100*err_t,'color',c(c_ind,:),'linewidth',5); hold on; grid on;
    set(gca,'FontSize',20); xlabel('Iteration');ylabel('Mis-Classification Error (%)'); 
    set(gca,'YLim',[5 30]);
    set(gca,'XTick',0:20:numIter);
    set(gca,'XLim',[0 numIter]);
    title(['Test Mis-Classification Error: v = ' num2str(v)]);
    text(numIter+1,100 - 100*err_t(end),['\lambda =' num2str(lam)],'Color','k','FontSize',10);
    c_ind = c_ind + 1;
end
end