% Aufgabe 6.8 aus dem Script
% Näherung mit summierter Trapezformel auf 1e-5 genau berechnen.

format compact
format short
clc

a = 0;
b = 0.5;
n = 4;
h = (b-a)/n;
MAX_FEHLER = 1e-5;

f = @(x) exp(-x.^2);
syms x
fdiff = matlabFunction(diff(f,x,2));

maxIntervall = max(abs(fdiff(a)), abs(fdiff(b)));
while (h^(2) * (b-a) * maxIntervall / 12 > MAX_FEHLER)
    n = n+1;
    h = (b-a)/n;
end
n
h

% Trapezregel
Tf = (f(a)+f(b))/2;
for i=1:n-1
   Tf = Tf + f(a+(i*h));
end
Tf = Tf * h;

abs(double(int(f,x,a,b)) - Tf)
