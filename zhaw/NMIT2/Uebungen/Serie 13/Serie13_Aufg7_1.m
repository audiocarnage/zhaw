% NMIT2 - Serie 13, Aufgabe 7.1

format compact; format long; clear all; clc;

f = @(t,y) -1/2.*y.*t.^2;
a = 0;
b = 3;
n = 3;
y0 = 3;
t = 0:3;
y = t';

dydt = f(t,y)

[t_euler,y_euler] = eulerverfahren(f,a,b,20,y0);

figure;
plot(t_euler,y_euler,'r');
hold on;
Richtungsfeld(f,t,y);
hold off;
xlim([-0.5 3.5]);
ylim([-0.5 3.5]);
legend('y(t)','Richtungsfeld');
