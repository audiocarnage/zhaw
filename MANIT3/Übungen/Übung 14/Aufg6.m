% MANIT3 - Serie 14, Aufgabe 6

% Annahme: das Modell ist binomial verteilt

format compact; format short; clear all; clc;

n = 600;
ausschuss = 90;

ausschussAnteil = ausschuss/n

N = 60;
p = 0.1;

mu = N * p
sigma = N * p * (1-p)

1-normcdf(12.5,mu,sigma)
