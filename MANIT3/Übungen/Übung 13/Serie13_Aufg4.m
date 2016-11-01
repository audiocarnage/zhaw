% MANIT3 - Serie 13, Aufgabe 4

format compact; format long; clear all; clc;

n = 120;
fremdkoerper = 300;
x = 0:n;
p = n/fremdkoerper
lambda = n*p
P = poisscdf(x,lambda);

[x' P']

figure;
bar(P);
xlabel('x');
ylabel('P(x)');
grid on;
