% SEP NMIT2, Aufgabe 1

format compact; format long; clear all; clc;

s = [0 1.0 2.5 5.5];
F = [0 0.4 1.8 8.5];

a = 0;
b = 6;

% Summierte Trapezformel
%W = 0;
%for i=1:(n-1)
%    Tf = Tf + f(a + i*h);
%end
%Tf = h * (((f(a) + f(b))/2) + Tf)

% b)
[yn,p] = LagrangeInterpolation(s,F,8.0)

f = @(x) p(4).*x.^3 + p(3).*x.^2 + p(2).*x + p(1);

f(8)

% c)
% Summierte Trapezformel
h = 0.01;
n = (b-a)/h;

Tf = 0;
for i=1:(n-1)
    Tf = Tf + f(a + i*h);
end
Tf = double(h * (((f(a) + f(b))/2) + Tf))

