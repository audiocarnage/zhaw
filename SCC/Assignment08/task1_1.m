% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Januar 2017
% 
% Task 1.1
% Scalar & Vector Functions

format compact; format shortE; clear; close all; clc;

xx = linspace(-pi,pi);
yy = linspace(-pi,pi);
[X,Y] = meshgrid(xx,yy);

f1 = @(x,y) (x.^2) - (y.^2);
f2 = @(x,y) x.*y.^2 .* (sin(x) + sin(y));

figure(1);
subplot(1,2,1), surf(xx,yy,f1(X,Y)), grid minor;
title('f(x,y) = x^2-y^2');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
colormap spring;

subplot(1,2,2), surf(xx,yy,f2(X,Y)), grid minor;
title('f(x,y) = xy^2(sin(x)+sin(y))');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
colormap spring;
