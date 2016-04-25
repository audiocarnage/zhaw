% Aufgabe 6.6 aus dem Script
% Gesucht ist eine Näherung für das Integral von f(x) = 1/x von 2 bis 4
% Rechteckregel: Substitution von f(x) durch eine Konstante (0. Grad)
% Trapezregel: Substitution von f(x) durch ein Polynom ersten Grades

format compact
clc

a = 2;
b = 4;
n = 4;
h = (b-a)/n;
f = @(x) 1/x;
F_eval = log(2)

% Rechteckregel
Rf = 0;
for i=0:n-1
    Rf = Rf + f(a+(i*h)+(h/2));
end
Rf = h * Rf

% Trapezregel
Tf = (f(a)+f(b))/2;
for i=1:n-1
   Tf = Tf + f(a+(i*h));
end
Tf = Tf * h
