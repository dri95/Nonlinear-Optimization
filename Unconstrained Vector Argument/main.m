
%% Section 1
%%-------------- Functions and Parameters ---------------%%

syms x1 x2

fun1 = (2*x2^3 - 6*x2^2 + 3*x1^2*x2); % f1 
initial_guess1 = [0,0]; %new proposed starting point[1.5,1.5]

fun2 = 100*(x2 - x1^2)^2 + (1 - x1)^2; % f2 
initial_guess2 = [0,0];% new proposed starting point[1.4,2]

fun3 = (x1 - 2*x2)^4 + 64*x1*x2; % f3 
initial_guess3 = [0,0];%new proposed starting point [3,2]

% back tracking parameters
alpha = 0.1;
beta = 0.6;

% intital guess and points for fermats's problem
initial_guess = [0,0];

%Regular pentagon centered at (1,1)
pointsregular = [[1,-1];[-1,0];[0,3];[2,3];[3,0]];

%pointsdemogen = randi([-100 100],10,2) demo1
pointsdemo1=[51,68;-49,-49;1,63;40,-52;79,86;92,-30;9,-61;-73,-50;-70,23;-49,-5];

%pointsdemogen2 = randi([-25 87],10,2) demo2
pointsdemo2=[14,-17;68,-19;41,34;37,63;78,80;7,-11;60,39;60,28;17,-24;39,9];

%backtracking parameters to solve fermat
alphaf = 0.5;
betaf = 0.9;


%% Section 2
%%--------------1 Steepest decent without backtracking --------------%%
[minimizerf1nb,f_evalf1nb,iterationsf1nb] = steep_decent(fun1,initial_guess1);% f1

[minimizerf2nb,f_evalf2nb,iterationsf2nb] = steep_decent(fun2,initial_guess2);% f2

[minimizerf3nb,f_evalf3nb,iterationsf3nb] = steep_decent(fun3,initial_guess3);% f3

%% Section 3
%%--------------1.1 Steepest decent with backtracking --------------%%
[minimizerf1,final_ssf1,f_evalf1,iterationsf1] = steepest_decent(fun1,initial_guess1,alpha,beta);% f1

[minimizerf2,final_ssf2,f_evalf2,iterationsf2] = steepest_decent(fun2,initial_guess2,alpha,beta);% f2

[minimizerf3,final_ssf3,f_evalf3,iterationsf3] = steepest_decent(fun3,initial_guess3,alpha,beta);% f3

%% Section 4
%%--------------2 Fermat's Problem(Data for debugging)(Newton's)  --------------%%
[minimizerdebu,final_ssdebu,f_evaldebu,iterationsdebu] = fermatsteepest(initial_guess,alphaf,betaf,pointsregular); % regular polygon

%%--------------2.1 Fermat's Problem(Data for Demonstration)(Newton's)  --------------%%
[minimizerdemo1,final_ssdemo1,f_evaldemo1,iterationsdemo1] = fermatsteepest(initial_guess,alphaf,betaf,pointsdemo1); % pointsdemo 1

[minimizerdemo2,final_ssdemo2,f_evaldemo2,iterationsdemo2] = fermatsteepest(initial_guess,alphaf,betaf,pointsdemo2); % pointsdemo 2






