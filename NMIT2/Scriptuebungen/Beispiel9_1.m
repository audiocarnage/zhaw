% Matlab Skript zu Bsp 9.4

format compact; format shortE; clear all; clc;

x = 0:1:4;
y = [ 3 1 0.5 0.2 0.05 ];

syms a b
f = @(x) a * exp(b*x);
sum1 = 0;
for i=1:5
    sum1 = sum1+(y(i)-a*exp(b*x(i))) * exp(b*x(i));
end
sum1 = -2*sum1;
sum2 = 0;

for i=1:5
    sum2 = sum2+(y(i)-a*exp(b*x(i))) * a*exp(b*x(i)) * x(i);
end

sum2 = -2*sum2;
f1 = simplify(sum1);
f2 = simplify(sum2);
Df = jacobian([f1, f2], [a,b]);
Df = matlabFunction(Df);
f1 = matlabFunction(f1);
f2 = matlabFunction(f2);
fvec = @(x) [f1(x(1),x(2)); f2(x(1), x(2))];
Dfvec = @(x) Df(x(1),x(2));
tol = 1e-5;
x0 = [3, -1]';
xn = x0 ;
err = tol+1;
n = 0;

while err > tol
    Dx = -Dfvec(xn)\fvec(xn);
    xn = xn + Dx;
    err = norm(fvec(xn),2);
    n = n+1;
end

xn
