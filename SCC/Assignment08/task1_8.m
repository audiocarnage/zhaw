% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Dezember 2016
% 
% Task 1.8
% Numerical solution of the Initial Value Boundary Problem 
% for the Wave Equation in 1D

format compact; format shortE; clear; close all; clc;

% Params
c = 1;
L = 1;

% initial conditions
% f(x) = u(x,0)
% g(x) = du(x,0)
f = @(x) ((x/L) .* ((1-x)/L));
g = @(x) ((x/L).^2 .* ((1-x))/L);

% Same parameters as in task 1.6
x = linspace(0,L);
t = linspace(0,4,1e4);
u_initial = f(x);
du_initial = g(x);
u0_boundary = zeros(1,length(t));
uL_boundary = zeros(1,length(t));

u = Wave_PDE_Task1_8(x,t,u_initial,du_initial,u0_boundary,uL_boundary,c);

figure(1);
surf(x,t,u'), grid minor;
colormap(jet(200));
title({'Task 1.8 - Numerical solution of the wave equation in 1D';...
      'Parameters as in task 1.6'});
xlabel('x');
ylabel('t');
zlabel('u(x,t)');
colorbar;


% New parameters
x = 0:0.1:1;
t = 0:0.01:9;
u_initial = x.*(1-x);
du_initial = ones(size(u_initial)) * 0.2;
u0_boundary = zeros(1,length(t));
uL_boundary = zeros(1,length(t));

u = Wave_PDE_Task1_8(x,t,u_initial,du_initial,u0_boundary,uL_boundary,c);

figure(2);
surf(x,t,u'), grid minor;
colormap(jet(200));
title({'Task 1.8 - Numerical solution of the wave equation in 1D',...
      'New parameters'});
xlabel('x');
ylabel('t');
zlabel('u(x,t)');
colorbar;


% Animation
for i=1:length(t)
    figure(3);
    plot(x,u(i)','b-','LineWidth',2);
    hold on;
    axis([0, 1, 0, 9]);
    pause(0.01);
end
