college = csvread('collegenum.csv', 1, 1);
s = RandStream('mt19937ar','Seed',15);
college = college(randperm(s,size(college, 1)), :);

%80:20 train test split
traincollege = college(1:620,:);
unseentestcollege = college(621:777,:);

K = 10;
[trainSet , testSet] = Kfold(traincollege,K);

% Evaluation Metrices 
  R2 = zeros(10,1);
  MSE = zeros(10,1);
  SD = zeros(10,1);
  MEAN = zeros(10,1);
  
for fold = 1:10
    
    % setting TRAIN and TEST folds
    trainX = cell2mat(trainSet(fold,:));
    testX = cell2mat(testSet(fold,:));
    Ytrain = trainX(:,2);
    Ytest = testX( :,2);
    trainX(:,2) = [];
    testX(:,2) = [];
    Xtrain = [ones(length(trainX),1),trainX];
    Xtest = [ones(length(testX),1),testX];
    [m,n] = size(Xtest);
    
    % OLS equation
    W = (Xtrain'*Xtrain)^-1*Xtrain'*Ytrain;
    
    % Prediction  
    Ypredicted = Xtest * W;
    
    %Sum of Squared Errors
    E = (Ytest - Ypredicted); 
    SSE = E'*E;
   
    % Total sum of squares
    Yvary = Ytest - mean(Ytest);
    SSTO = Yvary'*Yvary;
    
    % Goodness of fit test RSquared for each fold
    r2f = 1 - (SSE/SSTO) ;
    
    % Root Mean Squared Error, Mean , Standard Deviation for each fold
    rmsef = sqrt((sum((Ypredicted - Ytest).^2))/m);
    meanf = mean(Ypredicted);
    sdf = std(Ypredicted);
    MSE(fold) = rmsef;
    R2(fold) = r2f; 
    MEAN(fold)= meanf;
    SD(fold)= sdf;        
        
end

table = table(MSE,SD,MEAN,R2);
% Average of the metrices
R2f = mean(R2);
MSEf = mean(MSE);
MEANf = mean(MEAN);
SDf = mean(SD);

