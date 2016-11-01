% MANIT3 - Serie 13, Aufgabe 2

format compact; format short; clear all; clc;

x = 0:30;
lambda = 9;
P = poisscdf(x,lambda);

figure;
bar(P);
xlabel('x');
ylabel('P(x)');
grid on;
