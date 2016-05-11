% MANIT3 - Serie 14, Aufgabe 1
% Modell X~B(0.05,1200)
% gesucht: P(X > 0.05*200)

format compact; format short; clear all; clc;

p = 0.05;
N = 200;

abweichung = (p * N) + 0.5

mu = p * N
sigma = sqrt(p * (1-p) * N)

1-normcdf(abweichung,mu,sigma)
