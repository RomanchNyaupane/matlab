% take inputs from the user
n = input('enter the value of n: ');
y0 = input('enter y(x0): ');
x0 = input('enter x0: ');
yn = input('enter y(xn): ');
xn = input('enter xn: ');
p = input('enter p(x): ','s');
q = input('enter q(x): ','s');
r = input('enter r(x): ','s');

% convert the input strings into function handles
p = inline(p,'x');
q = inline(q,'x');
r = inline(r,'x');

h = (xn-x0)/n;
xval = x0:h:xn;
if(n<2)
    disp('the value of n cannot be less than 2');
    return;
end

% initialize arrays
arr_sub_diag = zeros(1,n-1);
arr_diag = zeros(1,n-1);
arr_super_diag = zeros(1,n-1);
arr_rhs = zeros(1,n-1);

% compute the tridiagonal matrix coefficients and right-hand side values
for i = 0:n-2
    arr_sub_diag(i+1) = 2-h*p(xval(i+2));
    arr_diag(i+1) =-4+2*h*h*q(xval(i+2));
    arr_super_diag(i+1) = 2+h*p(xval(i+2));
    arr_rhs(i+1) = 2*h*h*r(xval(i+2));
    % adjust the right-hand side values for boundary conditions
    if(i==0)
        arr_rhs(i+1) = arr_rhs(i+1) - (2-h*p(xval(i+2)))*y0;
    end
    if(i==n-2)
        arr_rhs(i+1) = arr_rhs(i+1) - (2+h*p(xval(i+2)))*yn;
    end
end
arr_rhs = arr_rhs';

% solve the tridiagonal system
solution = Tridiag(arr_sub_diag, arr_diag, arr_super_diag, arr_rhs);

% plot the solution
plot(xval, [y0 solution yn], 'b-');  % plot the solution points with initial values
hold on;
yval=[y0 solution yn];

plot(xval, yval, 'ro');  % plot x vs y with red dots at specified points
hold on;

% annotate the points
for i = 1:length(xval)
    text(xval(i), yval(i), ['(' num2str(xval(i)) ', ' num2str(yval(i)) ')'], 'VerticalAlignment', 'bottom');
end
xlabel('x');
ylabel('y');
title('Plot of x vs y');
hold off;