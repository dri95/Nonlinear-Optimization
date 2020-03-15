function[xout, fout] = goldensection(fun,xintvl,iter,tc)
 I1 = xintvl(2) - xintvl(1);
 K = ((1+sqrt(5))/2); % golden ratio
 i = 0;
   while ((abs(I1)>tc) && (i<iter))
    xL = xintvl(1); % lower x
    xU = xintvl(2); % upper x
    d = (xU - xL)/K; % g ratio
    x1 = xL + d; % x optimum option 1
    x2 = xU - d; % x optimum option 2
    fx1 = fun(x1); % evaluating the function at x1
    fx2 = fun(x2); % evaluating the function at x2
    % compare f(x) to find the smaller value
    if fx1 < fx2
        out = x1; % x optimum
        xintvl = [x2 xU]; % new guess x bracket = [xL xU]
    else
        out = x2; % x optimum
        xintvl = [xL x1]; % new guess x bracket = [xL xU]
    end
       i = i+1; % increase counter
    
    end

       final= feval(fun,out); % evaluating the function at the minimizer
       xout  = [xintvl(1) xintvl(2)]; % final x bracket
       fout  = final; % estimated objective near the minimizer.
       
       

%----------------------plotting-------------------------------------%       

ff1 = @(x) -5*x^5 + 4*x^4 - 12*x^3 + 11*x^2 - 2*x + 1 ;       
ff2 = @(x) (log(x-2)).^2 + (log(10-x)).^2 -x.^0.2 ;    
ff3 = @(x) -3.*x.*sin(0.75.*x) + exp(-2*x);     
ff4 = @(x) exp(3*x)+5.*exp(-2*x);

       
hold on

if isequal(ff1(1),fun(1))
x = -0.5:0.1:0.5;
y = -5.*x.^5+4.*x.^4-12.*x.^3+11.*x.^2-2.*x+1;
title('Golden Section for Function 1');
fprintf(' GS For f1 \n fout = %f \n' ,fout)
disp([' xout : [' num2str(xout(:).') ']']) ;

elseif isequal(ff2(1),fun(1))
x = 6:0.1:9.9;
y = (log(x-2)).^2 + (log(10-x)).^2 - x.^0.2;
title('Golden Section for Function 2');
fprintf(' GS For f2 \n fout = %f \n' ,fout)
disp([' xout : [' num2str(xout(:).') ']']) ;


elseif isequal(ff3(1),fun(1))
x = 0:0.1:2*pi;
y = -3.*x.*sin(0.75.*x) + exp(-2*x);
title('Golden Section for Function 3');
fprintf(' GS For f3 \n fout = %f \n' ,fout)
disp([' xout : [' num2str(xout(:).') ']']) ;


elseif isequal(ff4(1),fun(1))
x = 0:0.1:1.25;
y = exp(3*x)+5.*exp(-2*x);
title('Golden Section for Function 4');
fprintf(' GS For f4 \n fout = %f \n' ,fout)
disp([' xout : [' num2str(xout(:).') ']']) ;

else
x = 0:0.1:2.5;
y = 0.2.*x.*log(x)+(x-2.3).^2;
title('Golden Section for Function 5');
fprintf(' GS For f5 \n fout = %f \n' ,fout)
disp([' xout : [' num2str(xout(:).') ']']) ;

end

plot(x,y,'r')
hold on 
scatter((out),(fout),2,'*','MarkerEdgeColor','b','MarkerFaceColor','b');

xlabel('x');    
ylabel('f(x)');
legend('function','minimizer');
box on

figure;
end     