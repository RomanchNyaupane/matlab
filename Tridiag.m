function x = Tridiag(e,f,g,r)
% e = sub-diagonal vector
% f = diagonal vector
% g = super-diagonal vector
% r = RHS vector

n=length (f);

% forward elimination
for k= 2:n
factor = e(k)/f(k-1);       % since the position of sub diagonal and diagonal elements are same in array but different in matrix, we need to make sure index of e is always greater than index of g
f(k) = f(k) - factor*g(k-1);
r(k) = r(k) - factor*r(k-1);
end
% back substitution
% x = solution vector
x(n) = r(n)/f(n);       % in back substitution, we already know nth value
for k = n-1:-1:1
x(k) = (r(k)-g(k)*x(k+1))/f(k);
end

for i = 1:length(x)
fprintf('\ny%d = %f\n', i, x(i));
end