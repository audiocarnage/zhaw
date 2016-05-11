% MANIT3 - Serie 14, Aufgabe 2

% 2 Schiffe: die Wahrscheinlichkeit, dass ein Passagier ein Schiff auswählt
% ist 0.5

format compact; format short; clear all; clc;

% Wahrscheinlichkeit
p = 0.5;

% 1000 Personen (Passagiere)
n = 1000;

% 99% der Personen werden auf dem Schiff untergebracht.
% Das Modell ist binomial verteilt.
% X ~ B(0.5,1000)
mu = n*p
sigma = sqrt(n*p*(1-p))

norminv(0.99,mu,sigma)
