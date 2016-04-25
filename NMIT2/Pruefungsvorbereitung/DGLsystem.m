% Lösen mit modifiziertem Eulerverfahren
% a * y'' + b * y' + c * y = cos(2*t)

format compact; format shortE; clear all; clc;

y0 = 0;
y0diff = 0;
a = 0;
b = 1;
n = 5;
h = (b-a) / n;
tn = a:h:b;

syms  alpha beta gamma
f = @(t,z) [z(2,1) (-(beta/alpha) .* z(2,1)) - ((gamma/alpha) .* z(1,1)) + ((1/alpha) .* cos(2.*t))]'

z0 = [0 0]';
x_modeuler(1) = a;
y_modeuler(:,1) = sym(z0);

for i=1:n
    x_modeuler(i+1) = x_modeuler(i) + h;
    yeuler = y_modeuler(:,i) + (h .* f(x_modeuler(i), y_modeuler(:,i)));
    k1 = f(x_modeuler(i), y_modeuler(:,i));
    k2 = f(x_modeuler(i+1), yeuler);
    y_modeuler(:,i+1) = simplify(y_modeuler(:,i) + (h .* ((k1+k2) / 2)));
end

x_modeuler
y_modeuler(:,n)
