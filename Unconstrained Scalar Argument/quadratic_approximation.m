function [xout,fout]= quadratic_approximation(fun,xintvl)
syms x
fprime = matlabFunction( diff(fun(x)) ); % first derivative of the  function w.r.t x

x1 = xintvl(1); % lower x
x2 = xintvl(2); % upper x
f1 = fun(x1); % evaluating the function at x1   
f2 = fun(x2); % evaluating the function at x2

% Setting the bracket point with the largest objective value as x1
if ( f1 > f2 )
    x1 = xintvl(1);
    x2 = xintvl(2);
else
    x1 = xintvl(2);
    x2 = xintvl(1);
end
% evaluating the function at x1(point with the largest objective value for f(x)
f1 = fun(x1);    
% evaluating the function at x2 
f2 = fun(x2); 
%evaluating the first derivative of the function at x1(point with the largest objective value for f(x)
f1_prime = fprime(x1) ; 

%calculating the minimizer according to formula described in  Antoniou  and  Lu
xmin = x1 + ((f1_prime*(x2-x1)^2)/(2*(f1-f2+f1_prime*(x2-x1))));

xout = xmin; % minimizer
fout = fun(xmin); % estimated objective near the minimizer.



%----------------------plotting-------------------------------------%       

ff1 = @(x) -5*x^5 + 4*x^4 - 12*x^3 + 11*x^2 - 2*x + 1 ;       
ff2 = @(x) (log(x-2)).^2 + (log(10-x)).^2 -x.^0.2 ;    
ff3 = @(x) -3.*x.*sin(0.75.*x) + exp(-2*x);     
ff4 = @(x) exp(3*x) + 5*exp(-2 * x);

       
hold on

if isequal(ff1(1),fun(1))
x = -0.5:0.1:0.5;
y = -5.*x.^5+4.*x.^4-12.*x.^3+11.*x.^2-2.*x+1;
title(' Quadratic Approximation for Function 1');
fprintf(' QA For f1 \n   xout = %f \t  fout= %f \n\n' ,xout,fout)

elseif isequal(ff2(1),fun(1))
x = 6:0.1:9.9;
y = (log(x-2)).^2 + (log(10-x)).^2 -x.^0.2;
title(' Quadratic Approximation for Function 2');
fprintf(' QA For f2 \n xout = %f \t  fout= %f \n\n' ,xout,fout)

elseif isequal(ff3(1),fun(1))
x = -60:0.1:2*pi;
y = -3*x.*sin(0.75*x) + exp(-2*x);
title(' Quadratic Approximation for Function 3');
fprintf(' QA For f3 \n  xout = %f \tfout= %d \n\n' ,xout,fout)

elseif isequal(ff4(1),fun(1))
x = 0:0.1:1.25;
y = exp(3*x) + 5*exp(-2 * x);
title('Quadratic Approximation for Function 4');
fprintf(' QA For f4 \n  xout = %f \t  fout= %f \n\n' ,xout,fout)

else
x = 0:0.1:2.5;
y = 0.2.*x.*log(x)+(x-2.3).^2;
title('Quadratic Approximation for Function 5');
fprintf(' QA For f5 \n   xout = %f \t  fout= %f \n\n' ,xout,fout)
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