% MANIT3 - Serie 9, Aufgabe 5

format compact; format short; clear all; clc;

c = 0.02;

syms t;
F = @(t) 1-exp(-c.*t);
f = @(t) c.*exp(-c.*t);

% a)
1-F(50)

% b) S(t) = 1-F(t) = e^(-c*t)
Jahre = double(solve(exp(-c.*t) == 0.25,t))

% c)
syms p
c_param = double(solve(exp(-p*20) == 0.5,p))
