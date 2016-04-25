% NMIT2 - Script übung 9.2

clear all; clc;

xi = 1:4;
yi = [7.1 7.9 8.3 8.8];

syms a b;
f = @(x,a,b) a*log(x+b)

%y = f(xi,a,b)

g = @(x,a,b) yi' - f(xi,a,b)

dg = jacobian(f,[a,b])

dgv = [-0.693147 -1/2; -1.09861 -1/3; -1.38629 -1/4; -1.60944 -1/5];
dgv'*dgv

