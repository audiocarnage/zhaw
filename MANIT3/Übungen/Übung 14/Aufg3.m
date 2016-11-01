% MANIT3 - Serie 14, Aufgabe 3

format compact; format short; clear all; clc;

% Wahrscheinlichkeit defekte Zündkerze
p = 1-0.95

% Stichprobe vom Umfang 500 Stück
n = 500

einwandfrei = (1-p)*n

% Annahme: binomiales Modell X ~ B(0.05,500)

% a)
% Beanstandung der Lieferung wenn > 30 defekt

mu = n*p
sigma = sqrt(n*p*(1-p))

% de Moivre - Laplace
% 30 + 0.5
1-normcdf(30.5,mu,sigma)


% b)
% Anteil schlecher Zündkerzen 7%,  
% Wahrscheinlichkeit, dass nicht reklamiert wird ?  P(X<30) = ?
p = 0.07

einwandrei = (1-p)*n

mu = n*p
sigma = sqrt(n*p*(1-p))

normcdf(30.5,mu,sigma)
