% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Dezember 2016
% 
% Task 1.4
% Ordinary linear homogenous partial differential equation of first order

format compact; format shortE; clear; close all; clc;

syms x y
u1 = @(x,y) cos(x.^2 + (1./y.^2));
u2 = @(x,y) (x.^2 + (1./y.^2)).^2;

gradu1 = jacobian(u1, [x,y])
gradu2 = jacobian(u2, [x,y])

x = linspace(-3,3);
y = linspace(1,5);

[X,Y] = meshgrid(x,y);

figure(1);
surf(X,Y,u1(X,Y)), grid minor;
title(func2str(u1));
xlabel('x');
ylabel('y');
zlabel('u(x,y)');

figure(2);
surf(X,Y,u2(X,Y)), grid minor;
title(func2str(u2));
xlabel('x');
ylabel('y');
zlabel('u(x,y)');
