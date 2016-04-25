% Serie12, Aufgabe 8

format shortE;
clc;

syms k1 k2 k3
f1 = k1*exp(k2)+k3-10;
f2 = k1*exp(2*k2)+2*k3-12;
f3 = k1*exp(3*k2)+3*k3-15;

Df = jacobian([f1,f2,f3],[k1,k2,k3])

Df = matlabFunction(Df,'vars',[k1,k2,k3])
f1  = matlabFunction(f1,'vars',[k1,k2,k3])
f2  = matlabFunction(f2,'vars',[k1,k2,k3])
f3  = matlabFunction(f3,'vars',[k1,k2,k3])

f_vec =@(k) [f1(k(1),k(2),k(3)),f2(k(1),k(2),k(3)),f3(k(1),k(2),k(3))]';
Df_vec =@(k) Df(k(1),k(2),k(3));

x(:,1) = [10,0.1,-1]';

%1. Schritt Newton-Verfahren, n=1
delta = -Df_vec(x(:,1))\f_vec(x(:,1));
x(:,2) = x(:,1) + delta;

tol = 1e-12;
n = 2;
while (norm(x(:,n) - x(:,n-1)) > tol)
    delta = -Df_vec(x(:,n))\f_vec(x(:,n));
    x(:,n+1) = x(:,n) + delta;
    n = n + 1;
end
x(:,n)
f_vec(x(:,n))

x1 = x(1,n);
x2 = x(2,n);
x3 = x(3,n);
f = @(x) double(x1)*exp(double(x2)*x)+(double(x3)*x)-500;

[root,rn,n] = NewtonVerfahren(f,15,tol)

r = 0:0.01:25;
p = x(1,n)*exp(x(2,n).*r)-x(3,n).*r;
plot(r,p,'r','LineWidth',2);
xlabel('Radius r [cm]');
ylabel('Druck p [N/cm^2]');
title('Serie 12 - Aufgabe 8');
grid on;
