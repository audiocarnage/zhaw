% Serie 12, Aufgabe 5
% Die M-Teilchen sind M ~ N(170,20) verteilt,
% die W-Teilchen sind W ~ N(160,15) verteilt.
% M und W seien von einander unabhängig.

format compact; format short; clear all; clc;

muM = 170;
muW = 160;

sigmaM = 20;
sigmaW = 15;

mu = muM + muW
sigma = sqrt(sigmaM^2 + sigmaW^2)

% a) Mit welcher Wahrscheinlichkeit ist ein W-Teilchen grösser als ein M-Teilchen?
% X = W-M
% => P(X > 0) = ?
% E[X] = E[W-M] = E[W] - E[M] = muW - muM = 160 - 170 = -10
% V[X] = V[W-M] = V[W + (-1) * M] = V[W] + (-1)^2 * V[M] = sigmaW + (-1)^2 * sigmaM = 15^2 + 1^2 * 20^2

mu_x = muW - muM
sigma_x_squared = sigmaW^2 + sigmaM^2
sigma_x = sqrt(sigma_x_squared)

% X ~ N(-10,25)
1-normcdf(0,mu_x,sigma_x)
