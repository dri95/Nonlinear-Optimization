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
%Best lamda
%lamdaset = [1.4];


% Evaluation Metrices for each lamda
R2lam = zeros(length(lamdaset),1);
RMSElam = zeros(length(lamdaset),1);
MEANlam = zeros(length(lamdaset),1);
SDlam = zeros(length(lamdaset),1);

%Outer loop to test all lamdas
for p = 1:length(lamdaset)
lamda = lamdaset(p);

% Evaluation Metrices for folds
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
    Xtrain = [ones(length(trainX),1),trainX];
    Xtest = [ones(length(testX),1),testX];
    [m,~] = size(Xtest);
    
    % Ridge Regression Equation
    W = ((Xtrain'*Xtrain + lamda*eye(size(Xtrain,2)))^-1*(Xtrain'*Ytrain)); 
    
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
    RMSE(fold) = rmsef;
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
best_lamda = lamdaset(idx);
%%
% PLOT RMSE vs lambdas
table = table(RMSE,SD,MEAN,R2); 
hold on
scatter(lamdaset,RMSElam)

scatter(best_lamda,min(RMSElam),50,'*')
hold off

hold on
plot(lamdaset,SDlam,'-.r','LineWidth',1.5)
plot(lamdaset,MEANlam,'--r','LineWidth',1.5)
plot(lamdaset,RMSElam,':r','LineWidth',1.5)
hold off

%%
%predict on Unseen Test
Ytrain = traincollege(:,2);
Ytest = unseentestcollege( :,2);
traincollege(:,2) = [];
unseentestcollege(:,2) = [];
trainX= traincollege;
testX=unseentestcollege;
Xtrain = [ones(length(trainX),1),trainX];
Xtest = [ones(length(testX),1),testX];
[t,n] = size(Xtest);

W = ((Xtrain'*Xtrain + best_lamda*eye(size(Xtrain,2)))^-1*(Xtrain'*Ytrain)); 
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











