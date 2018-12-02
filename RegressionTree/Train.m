function Train(directory,trainData,J)
data = feval('load',[directory '/' trainData '.txt']);
tree = RegressionTree(data(:,2:end),data(:,1),J,10);
filename = [directory '/tree_lindu_' num2str(J) '.mat'];
save(filename,'tree');
end