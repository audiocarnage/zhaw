% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Dezember 2016
% 
% Task 1.5
% Analytical solution of the Initial Value Boundary Problem 
% for the Heat Transfer Equation in 1D

format compact; format shortE; clear; close all; clc;

N = 40;
k = 1;
L = 1;
tmin = 0;
tmax = 0.25;

% Calculate coefficients b
b = zeros(1,N);
for n=1:N
    % f(x) = u(x,0) : initial condition
    f = @(x) 4*(x/L).*((1-x)/L) .* sin(n*pi*x/L);
    b(n) = 2/L * integral(f,0,L);
end

x = linspace(0,L);
t = linspace(tmin,tmax);

u = zeros(100,100);
for xi=1:length(x)
    for ti=1:length(t)
        for n=1:N
            u(xi,ti) = u(xi,ti) + (b(n) * sin(n*pi*x(xi)/L) * exp(-(n^2*pi^2*k/L^2)*t(ti)));
        end
    end
end

[X,T] = meshgrid(x);
figure(1);
surf(X,T,u), grid minor;
colormap(jet(200));
title('Task 1.5 - Heat conduction in 1D');
xlabel('x');
ylabel('t');
zlabel('u(x,t)');
colorbar;
