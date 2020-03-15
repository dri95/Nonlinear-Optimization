%% Section 1
%%-------------- Functions and Parameters ---------------%%

syms x

fun1 = @(x) -5*x^5 + 4*x^4 - 12*x^3 + 11*x^2 - 2*x + 1; % f1 and its bracket
xintvl1 = [-0.5 0.5];

fun2 = @(x) (log(x-2)).^2 + (log(10-x)).^2 -x.^0.2; % f2 and its bracket
xintvl2 = [6 9.9];

fun3 = @(x) -3*x.*sin(0.75*x) + exp(-2*x); % f3 and its bracket
xintvl3 = [0 2*pi];

fun4 = @(x) exp(3 * x) + 5 * exp(-2 * x); % f4 and its bracket
xintvl4 = [0 1];

fun5 = @(x) 0.2*x *log(x) + (x - 2.3)^2; % f5 and its bracket
xintvl5 = [0.5 2.5];

tc = 10^-3; % termination criterion
iter = 10; % No of iterations

alpha = .5;
beta = .5;

%% Section 2
%%--------------1 Golden section Search--------------%%
[gs1_xout,gs1_fout]= goldensection(fun1,xintvl1,iter,tc);% f1

[gs2_xout, gs2_fout]= goldensection(fun2,xintvl2,iter,tc);% f2

[gs3_xout, gs3_fout]= goldensection(fun3,xintvl3,iter,tc);% f3

[gs4_xout, gs4_fout]= goldensection(fun4,xintvl4,iter,tc);% f4

[gs5_xout, gs5_fout]= goldensection(fun5,xintvl5,iter,tc);% f5

%% Section 3
%%--------------2 Quadratic Approximation-------------%%
[qa1_xout,qa1_fout]= quadratic_approximation(fun1,xintvl1);% f1

[qa2_xout,qa2_fout]= quadratic_approximation(fun2,xintvl2);% f2

[qa3_xout,qa3_fout]= quadratic_approximation(fun3,xintvl3);% f3

[qa4_xout,qa4_fout]= quadratic_approximation(fun4,xintvl4);% f4

[qa5_xout,qa5_fout]= quadratic_approximation(fun5,xintvl5);% f5

%% Section 4
%%--------------3 Backsearch-------------%%
[bs1_xout, bs1_fout]=backsearch(-.5,fun1,alpha,beta);%f1

[bs2_xout, bs2_fout]=backsearch(9.9,fun2,alpha,beta);%f2

[bs3_xout, bs3_fout]=backsearch(2*pi,fun3,alpha,beta);%f3

[bs4_xout, bs4_fout]=backsearch(1,fun4,alpha,beta);%f4

[bs5_xout, bs5_fout]=backsearch(.5,fun5,alpha,beta);%f5
