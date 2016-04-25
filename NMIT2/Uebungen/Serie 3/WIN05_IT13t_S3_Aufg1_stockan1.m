% @author Georgiou Rémi (georgrem), Stocker André (stockan1)
clc; clear all; format long; format compact;

syms x

a = 1; b = 2; maxAbsErr = 10^-5;
fx = @(x) log(x.^2);

ddx = matlabFunction(diff(fx,x,2));
ddddx = matlabFunction(diff(fx,x,4));
Fx = integral(fx,a,b);

% Maxima von f''(x)
x = a : 0.01 : b;
x = abs(ddx(x));
maximaDdx = max(x);

disp('summierten Rechtecksregel');
h = sqrt((24*maxAbsErr) / ((b-a)*maximaDdx))
nMax = ceil((b-a) / h)
disp('--------');

disp('summierte Trapezregel');
h = sqrt((12*maxAbsErr) / ((b-a)*maximaDdx))
nMax = ceil((b-a) / h)
disp('--------');

disp('summierte Simpsonregel');
% Maxima von f(4)
x = a : 0.01 : b;
x = abs(ddddx(x));
maximaDdx = max(x);

h = nthroot((2880*maxAbsErr) / ((b-a)*maximaDdx),4)
nMax = ceil((b-a) / h)
h = (b-a) / nMax;
disp('--------');