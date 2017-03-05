% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Dezember 2016
% 
% Task 1.6
% Analytical solution of the Initial Value Boundary Problem 
% for the Wave Equation in 1D

format compact; format shortE; clear; close all; clc;

N = 40;
k = 1;
c = 1;
L = 1;
tmin = 0;
tmax = 4;

% IVB Problem for the wave equation is subject to two initial conditions,
% f(x) and g(x)
% Calculate coefficients a,b
a = zeros(1,N);
b = zeros(1,N);
for n=1:N
    f = @(x) ((x/L) .* ((1-x)/L)) .* sin(n*pi*x/L);
    g = @(x) ((x/L).^2 .* ((1-x))/L) .* sin(n*pi*x/L);
    a(n) = 2/L * integral(f,0,L);
    b(n) = 2/(n*pi*c) * integral(g,0,L);
end

x = linspace(0,L);
t = linspace(tmin,tmax);

u = zeros(100,100);
for xi=1:length(x)
    for ti=1:length(t)
        for n=1:N
            u(xi,ti) = u(xi,ti) + (sin(n*pi*x(xi)/L) * (a(n)*cos(n*pi*c*t(ti)) + b(n)*sin(n*pi*c*t(ti)/L)));
        end
    end
end

[X,T] = meshgrid(x);
figure(1);
surf(X,T,u), grid minor;
colormap(jet(200));
title('Task 1.6 - Wave equation in 1D');
xlabel('x');
ylabel('t');
zlabel('u(x,t)');
colorbar;
