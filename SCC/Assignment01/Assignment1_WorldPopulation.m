% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: September 2016
% 
% World population, Tasks 1.1 - 1.4
% 
% In 1960 the world population was 3.06 bn people, 
% the growth rate was approximately 2%.
% With this growth rate the world population would double every 35 years.
%
% Parameter study:
% - Higher growth rate and higher adverse effects results in slower
%   population growth.
% - Lower growth rate and little adverse effects result in fast population
%   growth but also quicker stabilisation of population the population
%   towards 10 bn.

format compact; format short; clear all; clc;

% Parameters
a = 1960;               % lower boundary
b = 2200;               % upper boundary
t0 = 1960;
y0 = 3.018;             % world population in year 1960
growthRate = 0.02;
g = 0.029;              % g = birth rate minus "natural" mortality rate
p = 2.941e-3;           % p > 0, constant parameter that includes adverse effects

% Estimated world population from year 1800 to 2015:
data_t = [1800,1850,1900,1950:5:2015];
data_p = [1,1.262,1.650,2.525,2.758,3.018,3.322,3.682,4.061,4.440,4.853,5.310,5.735,6.127,6.520,6.930,7.349];

% Exponential growth curve:
t1 = t0:10:b;
f1 = @(t) y0 .* exp(growthRate .* (t-t0));

% Solving ODE of simplified model:
dydt2 = @(t,y) growthRate * y;
[t2,y2] = ode45(dydt2,[t0 b],y0);

% Solving logistic ODE - Verhulst's idea:
% Include adverse effects of large populations.
% Introduce additional (constant) parameter p > 0 in the mortality rate m.
dydt3 = @(t,y) (g - p*y) * y;
[t3,y3] = ode45(dydt3,[t0 b],y0);

figure('name','World population growth rate');

subplot(2,1,1), plot(data_t,data_p,'d',t1,f1(t1),'-',t2,y2,'--o',t3,y3,'--');
title('World population growth rate  (Tasks 1.1 - 1.3)');
xlabel('t [year]');
ylabel('Population in bn');
grid minor;
ylim([0 15]);
legend('Estimated growth','Exponential growth','Simplified model','Verhulst model','location','NE');

% Verhulst model parameter study:
% g is the constant growth rate
% p is the constant parameter that includes adverse effects

g = 0.01:0.01:0.05;
p = 0.001:0.001:0.005;
assert(length(g) == length(p))

% new upper bound
b = 2500;

legende = cell(length(g),1);
for k=1:length(g)
    dydt = @(t,y) (g(k) - p(k)*y) * y;
    [t,y] = ode45(dydt,[t0 b],y0);
    subplot(2,1,2), plot(t,y,'-');
    hold on;
    legende{k} = ['g=' num2str(g(k)) ', p=' num2str(p(k))];
end

hold off;
title('Parameter study using the Verhulst model  (Task 1.4)');
xlabel('t [year]');
ylabel('Population in bn');
grid minor;
legend(legende','location','best');
