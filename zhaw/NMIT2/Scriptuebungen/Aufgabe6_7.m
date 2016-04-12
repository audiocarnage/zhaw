% Aufgabe 6.7 aus dem Script
% Simpsonregel: Substitution von f(x) durch ein Polynom zweiten Grades
% p(x) = a+b(x-a)+c(x-a)(x-b)

format compact
clc

a = 0;
b = 0.5;
n = 3;
h = (b-a)/2;
f = @(x) exp(-x.^2);
syms x
F_eval = double(int(f,x,a,b))

alpha = f(a);
beta = (f(b)-f(a))/(b-a);
gamma = (f(a)-(2*f((b+a)/2))+f(b))/(2*h^2);

p = @(x,alpha,beta,gamma) alpha + (beta*(x-alpha)) + (gamma*(x-alpha)*(x-beta));

Sf = h/3*(f(a)+(4*f((a+b)/2))+f(b))
abs_error = abs(F_eval - Sf)

