% NMIT2 - Serie 1, Aufgabe 1
% @author Georgiou Rémi (georgrem), Stocker André (stockan1)
% e^x in der Umgebung x0=0 nähern mit einem Polynom p(x) vom Grad 7.

format compact; format rat; clear all; clc;

x0 = 0;
GRAD = 7;
f1 = @(x) exp(x);

x = 1;
epowerx = 0;
for i=0:GRAD
    epowerx = epowerx + x^(i)/factorial(i);
end
epowerx

format short;

syms k
f = (1 + (1/k))^k;
eulerscheZahl = sum(subs(f, k, 1:GRAD))

abs_err_epowerx = abs(exp(1) - epowerx)
abs_err_e = abs(exp(1) - eulerscheZahl)
