format compact; format shortE; clear; close all; clc;

xx = linspace(-pi,pi);
yy = linspace(-pi,pi);
[X,Y] = meshgrid(xx,yy);

f1 = @(x,y) (x.^2-y.^2);
f2 = @(x,y) (x.*y.^2 .* (sin(x)+sin(y)));

figure(1);
surf(xx,yy,f1(X,Y)), grid minor;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title(sprintf('%s',func2str(f1)));
colorbar;

figure(2);
surf(xx,yy,f2(X,Y)), grid minor;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title(sprintf('%s',func2str(f2)));
colorbar;
