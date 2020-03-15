function[minimizer,final_ss,f_eval,iterations] = fermatsteepest(initial_guess,alpha,beta,points)
syms x1 x2
dim = size(points); 
col = dim(1);
fun = 0;
% function for calculating the euclidean distance.
for i = 1:col
fun = fun + sqrt((x1 - points(i,1))^2 + (x2 - points(i,2))^2);
end
stop = 0;
% initial step size
ss = 0.5;
% Initial Guess 
x_k = initial_guess;
% Convergence Criteria
e = 10^(-5); 
% Iteration Counter
iter = 0; 

while (stop == 0)
x = x_k(1);
y = x_k(2);
% evaluating the function at [x,y]
f_x_initial = double(subs(fun, {x1, x2}, {x,y}));
% Gradient
g = jacobian(fun);
% evaluating the gradient at [x,y]
J = double(subs(g, {x1, x2},{x(1),y(1)}));
% Hessian
hes = jacobian(g);
% evaluating the hessian at [x,y]
H = double(subs(hes, {x1, x2},{x(1),y(1)})); 
tk = inv(H); 
% Search Direction
dk = -tk*J';
x_b = x +(ss*dk(1)); 
y_b = y +(ss*dk(2));
% evaluating the function at new point [x,y]
f_b = double(subs(fun, {x1, x2}, {x_b, y_b})); 
% back tracking to find optimal step size using armijo's condition 
if (f_b < f_x_initial + alpha*ss*(dk.')*dk) 
ss = ss * beta;
end
% new estimate of minimizer after backingtracking
xnm = x +(ss*dk(1));
ynm = y +(ss*dk(2));
f_x_new = double(subs(fun, {x1, x2}, {xnm, ynm}));
% new minimizer
xk1 = [xnm,ynm]; 
hold on;
scatter(xnm,ynm,10,'*','MarkerEdgeColor','k','MarkerFaceColor','k')
% terminating condition
   if ((norm(xk1 - x_k)<= e) || (f_x_new > f_x_initial))
        % Minimizer
        minimizer = xk1;
        % Evaluating function at the minimizer
        f_eval = double(subs(fun, {x1, x2}, {xk1}));
        % Final step size
        final_ss = ss;
        stop = 1;
        % No.of Iterations
        iterations = iter;
        fprintf(' Stats: \n   Final step size = %f \n  f(minimizer)= %f \n  No.of Iterations = %f \n' ,final_ss,f_eval,iterations);
        display(minimizer)
        fprintf('Termination criteria reached')
   else
       x_k=xk1;
       iter = iter+1;
   end
   disp(iter)
end   
fcontour(fun,'LevelStep',10)
hold on
scatter(xk1(1),xk1(2),20,'o','MarkerEdgeColor','r','MarkerFaceColor','r')
hold on;
scatter(initial_guess(1),initial_guess(2),20,'*','MarkerEdgeColor','b','MarkerFaceColor','b')
hold on 
scatter(points(:,1),points(:,2),'filled','k')
grid on
box on
end

















