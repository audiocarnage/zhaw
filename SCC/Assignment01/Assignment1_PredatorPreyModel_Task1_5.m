% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: September 2016
% 
% Predator-Prey model (Lotke-Volterra model), Task 1.5
%
% Observation:
% The "frequency plot" shows a simple harmonic motion with a period of ~10 years.
% The population of predators is trailing that of the prey by a couple of years.
% => The system is in balance.
% The prey and predator populations oscillate around a fixed point in a cyclic manner. 

format compact; format short; clear all; clc;

plotGraphsVertically = false;

a = 0;               % lower boundary
b = 40;              % upper boundary
t0 = a;
y0 = [50; 30];
g = [0.5; 0.8; 0.008]

% Fixed point coordinates: (y1hut,y2hut)
y1hut = g(2)/g(3)
y2hut = g(1)/g(3)

dydt = @(t,y) [g(1)*y(1) - g(3)*y(1)*y(2); ...
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
title('Dynamics of the Lotke-Volterra Model  (Task 1.5)');
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
hold on;
plot(y1hut,y2hut,'o','MarkerSize',8,'LineWidth',2);
title('Phase space hare vs. lynx  (Task 1.5)');
xlabel('Number of prey (hare)');
ylabel('Number of predators (lynx)');
grid minor;
legend('Phase space','Fixed point','Location','NE');
hold off;
