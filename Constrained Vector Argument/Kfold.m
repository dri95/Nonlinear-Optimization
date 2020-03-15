function[Trainset,Testset] = Kfold(dataset,K)
%Size  of dataset
[L,N] = size(dataset);

% size for each fold
testSize = fix(length(dataset)/K);

% training & testing matrix creation
FoldTrainSet = cell(K,N);
FoldTestSet = cell(K,N);

% K-Fold Cross validation
for j = 1:N    
        for i = 1:K
            logicSet = false(L,1);
            % logical matrix determines which data to be used in training and
            % testing each iteration, ensuring all points get used.
            logicSet((testSize*(i-1)+1:testSize*i),1) = true;
            FoldTestSet{i,j} = dataset(logicSet(:),j);
            FoldTrainSet{i,j} = dataset(~logicSet(:),j);
        end
end
Trainset = FoldTrainSet;
Testset = FoldTestSet;
