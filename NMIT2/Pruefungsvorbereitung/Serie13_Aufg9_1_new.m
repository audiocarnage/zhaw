% NMIT2 - Serie 13, Aufgabe 9.1
% Lineare Ausgleichsrechnung

format compact; format long; clear all; clc;

x = 0:4
y = [6 12 30 80 140]
N = length(x);

A = [exp(x') ones(N,1)]

% Normalgleichungssystem lösen
lambda = (A'*A)\(A'*y')

figure;
plot(x,y,'x');
xi = linspace(0,5);
hold on;
plot(xi,lambda(1).*exp(xi)+lambda(2))
hold off;
grid on;
legend('Datenpunkte','Ausgleichsfunktion');
