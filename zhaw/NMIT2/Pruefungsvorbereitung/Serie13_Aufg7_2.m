% NMIT2 - Serie 13, Aufgabe 7.2

format compact; format long; clear all; clc;

f = @(t,y) t.^2 + 0.1*y;
a = -1.5;
b = 1.5;
n = 5;
y0 = 0;
y = @(t) -10*t.^2 - 200*t - 2000 + 1722.5 * exp(0.05*(2*t+3));

[t,y_euler] = eulerverfahren(f,a,b,n,y0);
tn = a:0.15:b;
y_eval = y(tn);

figure;
plot(t,y_euler,tn,y_eval);
hold on;
Richtungsfeld(f,tn,y_eval);
hold off;
legend('Eulerverfahren','y(t) exakt','Richtungsfeld');
