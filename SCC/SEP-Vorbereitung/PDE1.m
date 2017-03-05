% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Januar 2017
% 
% Partial derivatives of first order

format compact; format short; clear; close all; clc;

f = @(x,y) -((((x.^2)-1) + ((y.^2)-4)) + (((x.^2)-1) .* ((y.^2)-4))) ./ (((x.^2) + (y.^2) + 1).^2);

syms x y
z = @(x,y) 3*x*y^(3) + 10*y*x^(2) + 5*y + 3*y*sin(5*x*y);
jacobian(z, [x,y])

xx = linspace(-4,4);
yy = linspace(-4,4);
[X,Y] = meshgrid(xx,yy);

figure(1);
surf(xx,yy,f(X,Y)), grid minor;
title('');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
colormap summer;
colorbar;
