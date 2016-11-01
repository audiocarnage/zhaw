% Serie 12, Aufgabe 3
% Die Kosten pro Person für Pauschalreisen sind normalverteilt.
% Ein Veranstalter bietet zwei Pauschalreisen A und B an.
% Von insgesamt 120 Personen haben 40 das Angebot A gebucht, die anderen das Angebot B.
% Durch Zufallswahl wird aus den 120 Personen eine Person ausgewählt.
% Mit welcher Wahrscheinlichkeit sind die Kosten dieser Person kleiner als CHF 1300.- ?
% X ~ N(mu,sigma)

format compact; format short; clear all; clc;

muA = 1500;
muB = 1200;

sigmaA = 170;
sigmaB = 320;

% Personen
n = 120;
gebuchtA = 40;
gebuchtB = n - gebuchtA;
anteilA = gebuchtA/n;
anteilB = 1-anteilA;

% P(X < 1300) ?
normcdf(1300,muA,sigmaA)*anteilA + normcdf(1300,muB,sigmaB)*anteilB
