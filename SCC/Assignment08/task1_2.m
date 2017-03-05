% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Januar 2017
% 
% Task 1.2
% Partial derivatives of first order

format compact; format shortE; clear; close all; clc;

syms x y
f = @(x,y) x^(2)*y^(4) + exp(x)*cos(y) + 10*x - 2*y^(2) + 3;
gradf = jacobian(f, [x,y])
gfx = matlabFunction(gradf(1));
gfy = matlabFunction(gradf(2));

g = @(x,y) x*y^(2) * (sin(x) + sin(y));
gradg = jacobian(g, [x,y])
ggx = matlabFunction(gradg(1));
ggy = matlabFunction(gradg(2));

h = @(x,y) log(x + y^2) - exp(2*x*y) + 3*x;
gradh = jacobian(h, [x,y])
ghx = matlabFunction(gradh(1));
ghy = matlabFunction(gradh(2));

x0 = 0;
y0 = 0;
[gfx(x0,y0) gfy(x0,y0)]
[ggx(x0,y0) ggy(x0,y0)]
[ghx(x0,y0) ghy(x0,y0)]
