% MANIT3 - Serie 13, Aufgabe 3

format compact; format short; clear all; clc;

n = 200;
x = 0:15;
p = 0.02;
lambda = n*p
P = poisscdf(x,lambda);

[x' P']

figure;
bar(P);
xlabel('x');
ylabel('P(x)');
grid on;
