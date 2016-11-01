% Serie 12, Aufgabe 1
% Die Zufallsvariable X ist N(mu = 120, s = 8)-verteilt.

format compact; format long; clear all; clc;

mu = 120;
sigma = 8;

% a) P(X <= 123.65)

normcdf(123.65,mu,sigma)

% b)
2 * normcdf(110,mu,sigma)

% c)
norminv(1-0.75,mu,sigma)

% d)
F1156 = 1-normcdf(115.6,mu,sigma)
Fk = F1156-0.12
norminv(Fk,mu,sigma)
