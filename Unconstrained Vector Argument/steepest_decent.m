function[minimizer,final_ss,f_eval,iterations] = steepest_decent(fun,initial_guess,alpha,beta)
syms x1 x2
% intitial point
x_k = initial_guess;
% termination creterion
e = 10^(-5); 
%iteration count 
iter = 1;
%initial step size
ss = 0.5;
Stop = 0;
% Gradient 
g = gradient(fun);

while(Stop == 0)  
% assigning xand y co-ordinates      
x = x_k(1);
y = x_k(2);
% evaluating the gradient and function at [x,y]
f_x_initial = double(subs(fun, {x1, x2}, {x,y}));
grad_x_initial = double(subs(g, {x1, x2},{x,y}));
% Direction(derivative of the gradient)
d = -(grad_x_initial);
% new initial estimate of the minimizer
x_b = x +(ss*d(1)); 
y_b = y +(ss*d(2));
f_b = double(subs(fun, {x1, x2}, {x_b, y_b})); 
% back tracking to find optimal step size using armijo's condition  
while (f_b > f_x_initial + alpha*ss*(d.')*d)
ss = ss * beta;
xn = x +(ss*d(1)); 
yn = y +(ss*d(2));
f_b = double(subs(fun, {x1, x2}, {xn, yn}));
end
% new estimate of minimizer after backingtracking
xnm = x +(ss*d(1));
ynm = y +(ss*d(2));
f_x_new = double(subs(fun, {x1, x2}, {xnm, ynm}));
% new minimizer
xk1 = [xnm,ynm]; 
hold on;
scatter(xnm,ynm,10,'*','MarkerEdgeColor','k','MarkerFaceColor','k')
% terminating condition
   if (norm(xk1 - x_k)<= e) 
        % Minimizer
        minimizer = xk1;
        % Evaluating function at the minimizer
        f_eval = double(subs(fun, {x1, x2}, {xk1}));
        % Final step size
        final_ss = ss;
        Stop = 1;
        % No.of Iterations
        iterations = iter;
        fprintf(' SD For f1 \n   Final step size = %f \n  f(minimizer)= %f \n  No.of Iterations = %f \n' ,final_ss,f_eval,iterations);
        display(minimizer)
        fprintf('Termination criteria reached')
   else
       x_k=xk1;
       iter = iter+1;
   end
   disp(iter)
end   
%----------------------plotting-------------------------------------%     

fcontour(fun,'LevelStep',10)
hold on;
scatter(xk1(1),xk1(2),20,'o','MarkerEdgeColor','r','MarkerFaceColor','r')
hold on;
scatter(initial_guess(1),initial_guess(2),20,'*','MarkerEdgeColor','b','MarkerFaceColor','b')
figure;

fmesh(fun)
hold on;
scatter(xk1(1),xk1(2),20,'o','MarkerEdgeColor','r','MarkerFaceColor','r')
end
