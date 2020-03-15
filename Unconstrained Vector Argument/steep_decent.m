function[minimizer,f_eval,iterations] = steep_decent(fun,initial_guess)
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
f_x_initial = double(subs(fun, {x1, x2}, {x, y}));
grad_x_initial = double(subs(g, {x1, x2},{x,y}));
%  Direction(derivative of the gradient)
d = -(grad_x_initial); 
% new estimate of the minimizer
x_b = x +(ss*d(1)); 
y_b = y +(ss*d(2));
% new minimizer
xk1 = [x_b,y_b];
hold on;
scatter(x_b,y_b,10,'*','MarkerEdgeColor','k','MarkerFaceColor','k')
% evaluating the function at new point
f_x_new = double(subs(fun, {x1, x2}, {x_b, y_b}));
% terminating condition
   if ((norm(xk1 - x_k)<= e) || (f_x_new > f_x_initial))
        % Minimizer
        minimizer = xk1 ;
        % Evaluating function at the minimizer
        f_eval = double(subs(fun, {x1, x2}, {xk1}));
        Stop = 1;
        % Number of iterations
        iterations = iter;
        fprintf(' SD For f1 \n   No.of Iterations = %f \n  f(minimizer)= %f \n' ,iterations,f_eval)
        display(minimizer)
        fprintf('Termination criteria reached')
   else
       x_k=xk1;
       iter = iter+1;
    
   end
   display(iter)
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
%plot(x_new,y_new,'*');
scatter(xk1(1),xk1(2),20,'o','MarkerEdgeColor','r','MarkerFaceColor','r')
end





