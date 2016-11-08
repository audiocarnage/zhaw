% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: September 2016
% 
% Predator-Prey model (Lotke-Volterra model) with self-interaction, Task 1.6

format compact; format short; clear all; clc;

plotGraphsVertically = false;

a = 0;               % lower boundary
b = 200;             % upper boundary
t0 = a;
y0 = [50; 30];
g = [0.5; 0.8; 0.008; 5e-4]

dydt = @(t,y) [g(1)*y(1) - g(3)*y(1)*y(2) - g(4)*(y(1)^2); ...
               -g(2)*y(2) + g(3)*y(1)*y(2)];

% Solving ODE for predator-prey model:
[t,y] = ode45(dydt,[t0 b],y0);

figure('name','Predator-Prey Model');

% time series y1(t) and y2(t)
if (plotGraphsVertically == true)
    subplot(2,1,1), plot(t,y(:,1),'-',t,y(:,2),'--');
else
    subplot(1,2,1), plot(t,y(:,1),'-',t,y(:,2),'--');
end
title('Lotke-Volterra Model  (Task 1.6)');
xlabel('t [year]');
ylabel('Population of animals');
grid minor;
legend('Hare','Lynx','location','best');

% phase space y1(t) vs. y2(t)
if (plotGraphsVertically == true)
    subplot(2,1,2), plot(y(:,1),y(:,2));
else
    subplot(1,2,2), plot(y(:,1),y(:,2));
end
title('Phase space hare vs. lynx  (Task 1.6)');
xlabel('Number of prey (hare)');
ylabel('Number of predators (lynx)');
grid minor;
legend('Phase space','Location','NE');
