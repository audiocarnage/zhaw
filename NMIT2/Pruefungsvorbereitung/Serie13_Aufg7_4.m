% NMIT2 - Serie 13, Aufgabe 7.4

format compact; format long; clear all; clc;

% Parameter
f = @(x,y) y;
a = 0;
b = 1;
y0 = 1;

% run 1
h = 0.1;
n = (b-a)/h;
xi = a:h:b;
y_exakt = exp(xi);

[x_ab3,y_ab3] = AdamsBashforth3(f,a,b,n,y0);
[x_RK4,y_RK4] = RungeKutta4(f,a,b,n,y0);

figure;
semilogy(xi,abs(y_exakt-y_ab3),xi,abs(y_exakt-y_RK4));
title('Vergleich Fehler klassisches Runge-Kutta vs. Adams-Bashforth 3. Ordnung');
hold on;

% run 2
h = 0.05;
n = (b-a)/h;
xi = a:h:b;
y_exakt = exp(xi);

[x_ab3,y_ab3] = AdamsBashforth3(f,a,b,n,y0);
[x_RK4,y_RK4] = RungeKutta4(f,a,b,n,y0);

semilogy(xi,abs(y_exakt-y_ab3),xi,abs(y_exakt-y_RK4));
hold off;
xlabel('x');
ylabel('y(x)');
grid on;
legend('Fehler Adams-Bashforth h=0.1','Fehler Runge-Kutta h=0.1',...
    'Fehler Adams-Bashforth h=0.05','Fehler Runge-Kutta h=0.05',...
    'location','best');
