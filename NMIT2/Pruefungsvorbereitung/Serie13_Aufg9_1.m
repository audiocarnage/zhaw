% NMIT2 - Serie 13, Aufgabe 9.1
% Lineare Ausgleichsrechnung

format compact; format short; clear all; clc;

x = 0:4;
y = [6 12 30 80 140];
N = length(x);

f1 = exp(x);
f2 = ones(N,1);

A = [f1' f2];

% Normalgleichungssystem lösen
lambda = (A'*A)\(A'*y')

yhut = @(x) lambda(1).*exp(x) + lambda(2);
xi = linspace(x(1),5);

figure;
plot(x,y,'bo',xi,yhut(xi),'r')
xlabel('x');
ylabel('f(x)');
grid on;
