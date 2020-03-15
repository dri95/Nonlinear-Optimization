function [xout, fout] = backsearch(x1,fun,alpha,beta)
ss=0.3; % stepsize
steps = 2; % Number of steps for backtracking
syms x
fprime = matlabFunction( diff(fun(x)) ); % first derivative of the  function w.r.t x

% Determining the search direction
p = fprime(x1);
if ( p > 0 )
    d=-1;
else
    d=1;
end
i = 1;
     while ((ss<=0.9) && (i <= steps) ) % for two steps
       x1=x1+ss.*d; % generic line search equation
% armijo's condition in order to prevent large steps relative to decrease in the function
       if(fun(x1)<= (fun(x1)+alpha.*ss.*fprime(x1)*d)) 
       ss = ss * beta ;   
       end
       i = i+1; % increase counter

       x3 = x1; % value of x after 2 steps

     end

%set the x it occurred at
xout= x3;
fout= fun(x1);



%----------------------plotting-------------------------------------%       

ff1 = @(x) -5*x^5 + 4*x^4 - 12*x^3 + 11*x^2 - 2*x + 1 ;       
ff2 = @(x) (log(x-2)).^2 + (log(10-x)).^2 -x.^0.2 ;    
ff3 = @(x) -3.*x.*sin(0.75.*x) + exp(-2*x);     
ff4 = @(x) exp(3*x) + 5*exp(-2 * x);

       
hold on

if isequal(ff1(1),fun(1))
x = -0.5:0.1:0.5;
y = -5.*x.^5+4.*x.^4-12.*x.^3+11.*x.^2-2.*x+1;
title('Inexact Line Search for Function 1');
fprintf(' IE_LS For f1 \n   xout = %f \t  fout= %f \n\n' ,xout,fout)

elseif isequal(ff2(1),fun(1))
x = 6:0.1:9.9;
y = (log(x-2)).^2 + (log(10-x)).^2 -x.^0.2;
title('Inexact Line Search for Function 2');
fprintf(' IE_LS For f2 \n   xout = %f \t  fout= %f \n\n' ,xout,fout)

elseif isequal(ff3(1),fun(1))
x = 0:0.1:2*pi;
y = -3*x.*sin(0.75*x) + exp(-2*x);
title('Inexact Line Search for Function 3');
fprintf(' IE_LS For f3 \n   xout = %f \t  fout= %f \n\n' ,xout,fout)

elseif isequal(ff4(1),fun(1))
x = 0:0.1:1.25;
y = exp(3*x) + 5*exp(-2 * x);
title('Inexact Line Search for Function 4');
fprintf(' IE_LS For f4 \n   xout = %f \t  fout= %f \n\n' ,xout,fout)

else
x = 0:0.1:2.5;
y = 0.2.*x.*log(x)+(x-2.3).^2;
title('Inexact Line Search for Function 5');
fprintf(' IE_LS For f5 \n   xout = %f \t  fout= %f \n\n' ,xout,fout)
end

plot(x,y,'r')
hold on 
scatter((xout),(fout),20,'*','MarkerEdgeColor','b','MarkerFaceColor','b');

xlabel('x');    
ylabel('f(x)');
legend('function','minimizer');
box on

figure;
end     





