function Tree = RegressionTree(X,Y,J,minNodeSize)
emptyNode = struct('parent',-1, 'leftChild',-1, 'rightChild',-1, 'isTerminal',true,'splitDim',-1,...
                   'splitVal',-1,'regionVal',-1, 'gain', -1, 'dataPoints',[]);
Tree(1:2*J-1) = emptyNode;
Tree(1).dataPoints = 1:length(Y);
Tree(1).regionVal = mean(Y);
for i = 1:J-1
    max_vector = zeros(3,2*i-1);
    for j =1:2*i-1
        if Tree(j).isTerminal == 1 && length(Tree(j).dataPoints) > minNodeSize
            if Tree(j).gain >0
                max_vector(1,j) = Tree(j).gain;
                max_vector(2,j) = Tree(j).splitVal;
                max_vector(3,j) = Tree(j).splitDim;
                continue;
            end
            temp = zeros(2,size(X,2));
            for m = 1:size(X,2)
                [gain,sV] = FeatureGain(X(Tree(j).dataPoints,m),Y(Tree(j).dataPoints));
                temp(1,m) = gain;
                temp(2,m) = sV;
            end
            [temp_max,temp_ind] = max(temp(1,:));
            max_vector(1,j) = temp_max;
            max_vector(2,j) = temp(2,temp_ind);
            max_vector(3,j) = temp_ind;
            Tree(j).gain = temp_max;
            Tree(j).splitDim = temp_ind;
            Tree(j).splitVal = Tree(j).dataPoints(temp(2,temp_ind));
        end
    end 
    [mG,k] = max(max_vector(1,:));
    left = emptyNode;  
    right = emptyNode; 
    Tree(k).isTerminal = false;  
    Tree(k).rightChild = 2*i + 1;
    Tree(k).leftChild = 2*i;
    left.parent = k; 
    right.parent = k; 
    left.dataPoints = Tree(k).dataPoints(...
                      (X(Tree(k).dataPoints,Tree(k).splitDim) <= X(Tree(k).splitVal,Tree(k).splitDim)));
    left.regionVal = mean(Y(left.dataPoints));
    right.dataPoints = Tree(k).dataPoints(...
                      (X(Tree(k).dataPoints,Tree(k).splitDim) > X(Tree(k).splitVal,Tree(k).splitDim)));
    right.regionVal = mean(Y(right.dataPoints));
    Tree(2*i) = left; Tree(2*i+1) = right;
end
end