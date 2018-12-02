function SumResults(directory, trainData, testData, JJ)
pp1 = zeros(length(JJ),1);
pp2 = zeros(length(JJ),1);
TrainTime = zeros(length(JJ),1);
TestTime = zeros(length(JJ),1);
for i = 1:length(JJ) 
    J = JJ(i) 
    tic;
    Train(directory, trainData, J);
    TrainTime(i) = toc; 
    tic;
    [pp1(i),pp2(i)]=Test(directory, trainData, testData, J);
    TestTime(i) = toc;  
end;
figure(1);
plot(JJ,pp1,'--k','linewidth',2);hold on;
plot(JJ,pp2,'r','linewidth',2);hold on;
set(gca,'FontSize',20); ylabel('MSE');xlabel('# Terminal nodes (J)'); 
h = legend('Train','Test');
set(h,'Fontsize',10);
title([directory ':MSE']);
if ~strcmp(directory,'cadata')
    axis([0 300 20 140]);
    set(gca,'XTick',0:50:300);
else
    axis([0 1000 0 4]);
    set(gca,'XTick',0:200:1000);
end
grid on;

figure(2);
plot(JJ,TrainTime,'--k','linewidth',2);hold on;
plot(JJ,TestTime,'r','linewidth',2);hold on;
set(gca,'FontSize',20); ylabel('Time (sec)');xlabel('# Terminal nodes (J)');
l = legend('Train','Test');
set(l,'Fontsize',10);
title([directory ':Time']);
if ~strcmp(directory,'cadata')
    set(gca,'XTick',0:50:300);
else
    set(gca,'XTick',0:200:1000);
end
grid on;
%write summary
summary_matrix = zeros(length(JJ),5);
summary_matrix(:,1) = JJ';
summary_matrix(:,2) = pp1;
summary_matrix(:,3) = pp2;
summary_matrix(:,4)= TrainTime;
summary_matrix(:,5) = TestTime;
if ~strcmp(directory,'cadata')
    save summary_tele_lindu.txt -ascii summary_matrix;
else
    save summary_cada_lindu.txt -ascii summary_matrix;
end
end