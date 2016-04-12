% SEP NMIT2, Aufgabe 4

format compact; format long; clear all; clc;

% Paramter
a = 0;
b = 20;
i = @(t,y) 4.*cos(t) - (cos(t).*y);
h = 0.05;
y0 = 0;
n = (b-a)/h;


[x_euler,y_euler] = eulerverfahren(i,a,b,n,y0);
[x_RK4,y_RK4] = RungeKutta4(i,a,b,n,y0);

figure;
subplot(1,2,1), plot(x_euler,y_euler,x_RK4,y_RK4);
xlabel('x');
ylabel('');
legend('Euler-Verfahren','Runge-Kutta 4','location','best');
grid on;

% b)
i_exakt = @(t) 4.*(1-exp(-sin(t)));
t = linspace(a,b);
subplot(1,2,2), plot(t,i_exakt(t));
xlabel('x');
ylabel('');
grid on;

diff = abs(y_euler - y_RK4);
