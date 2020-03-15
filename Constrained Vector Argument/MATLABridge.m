college = csvread('collegenum.csv', 1, 1);

s = RandStream('mt19937ar','Seed',15);
college = college(randperm(s,size(college, 1)), :);

%80:20 train test split
traincollege = college(1:620,:);
unseentestcollege = college(621:777,:);

% Number of folds
K = 10;

% 10 fold cross validation splits
[trainSet , testSet] = Kfold(traincollege,K);

%Set of lamdas for testing
lamdaset = (0:0.1:20);
% Best lamda
%lamdaset = [2];

% Evaluation Metrices for each lamda
R2lam = zeros(length(lamdaset),1);
RMSElam = zeros(length(lamdaset),1);
MEANlam = zeros(length(lamdaset),1);
SDlam = zeros(length(lamdaset),1);

%Outer loop to test all lamdas
for p = 1:length(lamdaset)
lamda = lamdaset(p);

% Evaluation Metrices
R2 = zeros(10,1);
RMSE = zeros(10,1);
SD = zeros(10,1);
MEAN = zeros(10,1);

%Inner loop to test all folds

for fold = 1:10
    
    % setting TRAIN and TEST folds
    trainX = cell2mat(trainSet(fold,:));
    testX = cell2mat(testSet(fold,:));
    Ytrain = trainX(:,2);
    Ytest = testX( :,2);
    trainX(:,2) = [];
    testX(:,2) = [];
    %Xtrain = [ones(length(trainX),1),trainX];
    %Xtest = [ones(length(testX),1),testX];
    Xtrain = trainX;
    Xtest = testX;
    [m,~] = size(Xtest);
    
    % Perform Ridge
    W = ridge(Ytrain,Xtrain,lamda,0);
         
    % Prediction    
    Ypredicted = [ones(length(Xtest),1),Xtest] * W;
    
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
R2lam(p) = mean(R2);
RMSElam(p) = mean(RMSE);
MEANlam(p) = mean(MEAN);
SDlam(p) = mean(SD);
end
[~,idx]= min(RMSElam);
MATLAB_lamda = lamdaset(idx);
%%
table = table(RMSE,SD,MEAN,R2); 

hold on 
scatter(lamdaset,RMSElam)
scatter(MATLAB_lamda,min(RMSElam),50,'*')
hold on
plot(lamdaset,SDlam,'-.b','LineWidth',1.5)
plot(lamdaset,MEANlam,'--b','LineWidth',1.5)
plot(lamdaset,RMSElam,':b','LineWidth',1.5)


%%

%predict on Unseen Test
Ytrain = traincollege(:,2);
Ytest = unseentestcollege( :,2);
traincollege(:,2) = [];
unseentestcollege(:,2) = [];
trainX  = traincollege;
testX = unseentestcollege;
%Xtrain = [ones(length(trainX),1),trainX];
%Xtest = [ones(length(testX),1),testX];
Xtrain = trainX ;
Xtest = testX ;
[t,n] = size(Xtest);

W = ridge(Ytrain,Xtrain,MATLAB_lamda,0); 
    
    % Prediction  
    Ypredicted = [ones(length(Xtest),1),Xtest] * W;
    
    %Sum of Squared Errors
    E = (Ytest - Ypredicted); 
    SSE = E'*E;
   
    % Total sum of squares
    Yvary = Ytest - mean(Ytest);
    SSTO = Yvary'*Yvary;
    
    % Goodness of fit test RSquared for each fold
    R2MATtest = 1 - (SSE/SSTO) ;
    
    % Mean Squared Error, Mean , Standard Deviation for each fold
    RMSEMATtest = sqrt((sum((Ypredicted - Ytest).^2))/t);
    MEANMATtest = mean(Ypredicted);
    SDMATtest = std(Ypredicted);


tabletest = table(RMSEMATtest,SDMATtest,MEANMATtest,R2MATtest);     

hold on
plot(Ypredicted,'b*')









