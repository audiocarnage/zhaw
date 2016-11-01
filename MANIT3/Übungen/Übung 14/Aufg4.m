% MANIT3 - Serie 14, Aufgabe 4

format compact; format short; clear all; clc;

% Annahme: Modell ist binomial verteilt X ~ B(0.1,100)

p = 0.1
n = 100+12

brauchbareGeraete = n - (n * p)

% a)  97.5% Wahrscheinlichkeit, dass alle Geräte OK sind
% P(X >= 100) = ?

mu = n*p
sigma = sqrt(n*p*(1-p))

% de Moivre - Laplace
%
y = norminv(0.975,mu,sigma)
kaufen = ceil(100 + y)

% b) Das Unternehmen braucht 1000 einwandfreie Geräte
n = 1000 + 112

brauchbareGeraete = n - (n * p)

mu = n*p
sigma = sqrt(n*p*(1-p))

y = norminv(0.975,mu,sigma)
kaufen = ceil(1000 + y)
