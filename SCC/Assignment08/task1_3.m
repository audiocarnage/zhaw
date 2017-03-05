% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Januar 2017
% 
% Task 1.3
% Partial derivatives of first order

format compact; format shortE; clear; close all; clc;

syms x y
f =((x.^(2) - 1) + (y.^(2) - 4) + (x.^2 - 1) .* (y.^(2) - 4)) ./ -((x.^2+y.^(2) + 1).^2);
gradf = jacobian(f, [x, y])

ff = matlabFunction(f);
gfx = matlabFunction(gradf(1));
gfy = matlabFunction(gradf(2));

[xx,yy] = meshgrid(linspace(-4,4),linspace(-5,5));
zz = ff(xx,yy);

figure(1);
subplot(1,2,1), surf(xx,yy,zz), grid minor;
hold on;
quiver3(xx,yy,zz,gfx(xx,yy),gfy(xx,yy),(gfx(xx,yy).^(2) + gfy(xx,yy).^(2)),'r');
hold off;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
colormap(jet(200));
colorbar;

subplot(1,2,2), quiver3(xx,yy,zz,gfx(xx,yy),gfy(xx,yy),(gfx(xx,yy).^(2) + gfy(xx,yy).^(2)),'r');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
