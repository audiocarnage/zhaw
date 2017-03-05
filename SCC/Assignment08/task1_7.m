% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Dezember 2016
% 
% Task 1.7
% Numerical solution of the Initial Value Boundary Problem 
% for the Heat Transfer Equation in 1D

format compact; format shortE; clear; close all; clc;

% Params
k = 1;
L = 1;

% f(x) = u(x,0) : initial condition
f = @(x) 4*(x/L).*((1-x)/L);

% Same parameters as in task 1.5
x = linspace(0,L);
t = linspace(0,0.25,1e4);
u_initial = f(x);
u0_boundary = zeros(1,length(t));
uL_boundary = zeros(1,length(t));

u = Heat_PDE_Task1_7(x,t,u_initial,u0_boundary,uL_boundary,k);

figure(1);
surf(x,t,u'), grid minor;
colormap(jet(200));
title({'Task 1.7 - Numerical solution of the heat transfert equation in 1D';...
      'Parameters as in task 1.5'});
xlabel('x');
ylabel('t');
zlabel('u(x,t)');
colorbar;


% New parameters
x = 0:0.1:2;
t = 0:0.005:1.5;
u_initial = zeros(1,length(x));
u0_boundary = exp(-2*t) .* sin(50*t);
uL_boundary = exp(-3*t) .* cos(50*t);

u = Heat_PDE_Task1_7(x,t,u_initial,u0_boundary,uL_boundary,k);

figure(2);
surf(x,t,u'), grid minor;
colormap(jet(200));
title({'Task 1.7 - Numerical solution of the heat transfert equation in 1D',...
      'New parameters'});
xlabel('x');
ylabel('t');
zlabel('u(x,t)');
colorbar;
