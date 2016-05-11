% MANIT3 - Serie 4, Aufgabe 4

format short; format compact; clear all; clc;

gasv = [10 10.6 10.4 11.1 11.9 13.8 13.7 13.7 12.2 12.9 13.6 13.8 13.6 13.6 13.8]';
gaspr = [.92 1.04 1.15 1.11 1.08 1.11 1.05 .84 .8 .8 .82 .85 .83 .8 .78]';
fernwpr = [.9 1.04 1.08 1.11 1.1 1.11 1.14 1.07 1.02 1 1.01 1.02 1 .97 .95]';

N = length(gasv);
A = [ones(N,1) gaspr fernwpr];
[b,bint,R,RINT,stats] = regress(gasv,A);
b


x = inv(A'*A)*A'*gasv;
yhut = A*b;
R2 = stats(1)

f = @(x,y) b(1) + b(2).*x+ b(3).*y;

y = f(gaspr,fernwpr);
[yhut y gasv];
[R gasv-yhut];

figure;
plot(yhut,R,'bo');
title('Residuen');
xlabel('geschätzter Verbrauch');
grid on;
lsline