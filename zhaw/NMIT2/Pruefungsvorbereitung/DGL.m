% DGL 1. Ordnung lösen mit Einschrittverfahren

format compact; format long; clear all; clc;

% Paramter
a = 0;
b = 1;
f = @(x,y) y;
%n = 10
h = 0.1;
y0 = 1;
n = (b-a)/h;


[x_euler,y_euler] = eulerverfahren(f,a,b,n,y0);
[x_midpoint,y_midpoint] = mittelpunktverfahren(f,a,b,n,y0);
[x_modeuler,y_modeuler] = modeuler(f,a,b,n,y0);
[x_RK4,y_RK4] = RungeKutta4(f,a,b,n,y0);

figure;
plot(x_euler,y_euler,x_midpoint,y_midpoint,x_modeuler,y_modeuler,x_RK4,y_RK4);
hold on;   
Richtungsfeld(f,x_RK4,y_RK4);
hold off;
legend('Euler-Verfahren','Mittelpunktverfahren',...
    'Modifiziertes Euler-Verfahren','Runge-Kutta 4',...
    'Richtungsfeld','location','best');
