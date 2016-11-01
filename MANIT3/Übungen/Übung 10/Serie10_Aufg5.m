% Serie 10, Aufgabe 5

format compact; format short; clear all; clc;

n = 200;
p = 1/40;
x = 0:n;

% a) Binomialverteilung
y = binocdf(x,n,p);
figure;
bar(x,y,0.25);
grid on;

% b) F(4)
F4 = y(4+1)

% c)
syms m
s = ceil(vpa(solve(1 - ((40-1)/40)^(m) == 0.99, m)))
