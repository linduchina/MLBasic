function [tra_MSE, tre_MSE] = Test(directory, trainData, testData, J)
%Train(directory,trainData,J);
l_tree = load([directory '/tree_lindu_' num2str(J) '.mat']);
tree = l_tree.tree;
data1 = feval('load',[directory '/' trainData '.txt']);
data2 = feval('load',[directory '/' testData '.txt']);
tra_MSE = 0;
tre_MSE = 0;
% train set
for i = 1:length(data1(:,1))
%     for ind = 1:(2*J-1)
%        if tree(ind).isTerminal && (sum(i == tree(ind).dataPoints) ~=0)
%           tra_MSE = tra_MSE + (tree(ind).regionVal - data1(i,1)) * (tree(ind).regionVal - data1(i,1));
%           break;
%        end
%     end
    flag = 0;
    ind = 1;
    while flag == 0
       if tree(ind).isTerminal
          tra_MSE = tra_MSE + (tree(ind).regionVal - data1(i,1)) * (tree(ind).regionVal - data1(i,1));
          break;
       elseif data1(tree(ind).splitVal,tree(ind).splitDim + 1) >= data1(i,tree(ind).splitDim + 1)
          ind = tree(ind).leftChild;
       elseif data1(tree(ind).splitVal,tree(ind).splitDim + 1) < data1(i,tree(ind).splitDim + 1)
          ind = tree(ind).rightChild;
       end
    end
end
tra_MSE = tra_MSE / length(data1(:,1));
% test set
for i = 1:length(data2(:,1))
    flag = 0;
    ind = 1;
    while flag == 0
       if tree(ind).isTerminal
          tre_MSE = tre_MSE + (tree(ind).regionVal - data2(i,1)) * (tree(ind).regionVal - data2(i,1));
          break;
       elseif data1(tree(ind).splitVal,tree(ind).splitDim + 1) >= data2(i,tree(ind).splitDim + 1)
          ind = tree(ind).leftChild;
       elseif data1(tree(ind).splitVal,tree(ind).splitDim + 1) < data2(i,tree(ind).splitDim + 1)
          ind = tree(ind).rightChild;
       end
    end
end
tre_MSE = tre_MSE / length(data2(:,1));
end