% MANIT3 - Serie 9, Aufgabe 3
% F(t) = P(T<=t)
% 1-F(t) = P(T>t)

format compact; format short; clear all; clc;

x = linspace(0,12);

F = @(x) x./6 - x.^(2)./144;
f = @(x) 1/6 - x./72;

% a)
figure;
plot(x,F(x),x,f(x));
xlabel('t');
ylabel('y');
grid on;
legend('Verteilungsfunktion F(t)','Dichtefunktion f(t)','location','best');

% b1) P(x < -2)
0

% b2) F(1)
F(1)

% b3) 1-F(6)
1-F(6)

% c) Median berechnen
syms x
median = double(solve(x./6 - x.^(2)./144 == 0.5,x))
