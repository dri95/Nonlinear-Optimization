college = csvread('collegenum.csv', 1, 1);

s = RandStream('mt19937ar','Seed',15);
college = college(randperm(s,size(college, 1)), :);

%80:20 train test split
traincollege = college(1:620,:);
unseentestcollege = college(621:777,:);

Ytrain = traincollege(:,2);
Xtrain = [ones(length(traincollege),1) traincollege(:,1) traincollege(:,3:end)];

%perform lasso
[~ ,FitInfo] = lasso(Xtrain,Ytrain);

%finding best lamda and converting mse to rmse
[~,idx]=min(FitInfo.MSE);
minmse = min(FitInfo.MSE);
minrmse = sqrt(minmse);
lamda=FitInfo.Lambda(idx);
lammset =(FitInfo.Lambda);
mse = (FitInfo.MSE);
rmse = sqrt(mse);
hold on 
scatter(lammset,rmse);
plot(lamda,minrmse,'*')


% Number of folds
K = 10;

% 10 fold cross validation splits
[trainSet , testSet] = Kfold(traincollege,K);

% Evaluation Metrices
R2 = zeros(10,1);
RMSE = zeros(10,1);
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
    [m,~] = size(Xtest);
    
    % Perform lasso
    W = lasso(Xtrain,Ytrain,'Lambda',lamda);
         
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
    
    % Mean Squared Error, Mean , Standard Deviation for each fold
    msef = sqrt((sum((Ypredicted - Ytest).^2))/m);
    meanf = mean(Ypredicted);
    sdf = std(Ypredicted);
    RMSE(fold) = msef;
    R2(fold) = r2f; 
    MEAN(fold)= meanf;
    SD(fold)= sdf;
       
end
 
%%
tabletrain = table(RMSE,SD,MEAN,R2); 

%%

%predict on Unseen Test

Ytest = unseentestcollege( :,2);
unseentestcollege(:,2) = [];
testX = unseentestcollege;
Xtest = [ones(length(testX),1),testX];

[t,n] = size(Xtest);

W = lasso(Xtrain,Ytrain,'Lambda',lamda);
    
    % Prediction  
    Ypredicted = Xtest * W;
    
    %Sum of Squared Errors
    E = (Ytest - Ypredicted); 
    SSE = E'*E;
   
    % Total sum of squares
    Yvary = Ytest - mean(Ytest);
    SSTO = Yvary'*Yvary;
    
    % Goodness of fit test RSquared for each fold
    R2test = 1 - (SSE/SSTO) ;
    
    % Mean Squared Error, Mean , Standard Deviation for each fold
    RMSEtest = sqrt((sum((Ypredicted - Ytest).^2))/t);
    MEANtest = mean(Ypredicted);
    SDtest = std(Ypredicted);

tabletest = table(RMSEtest,SDtest,MEANtest,R2test);  
hold on
plot(Ypredicted,'r*')
plot(Ytest,'ko')











