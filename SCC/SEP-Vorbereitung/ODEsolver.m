% Lösen eines Systems von Differentialgleichungen

format compact; format short; clear; close all; clc;

a = -2;
b = 6;
y0 = [1;1;0];

dydt = @(t,y) [sin(t)*exp(t)-y(2); ...
               y(1)-y(2); ...
               2*cos(t) / exp(t) + y(1)];
[t,y] = ode45(dydt,[a b],y0)

figure(1);
plot(t,y(:,1), t,y(:,2), t,y(:,3)), grid minor;
xlabel('t');
ylabel('y(t)');
legend('y1','y2','y3','Location','Best');
