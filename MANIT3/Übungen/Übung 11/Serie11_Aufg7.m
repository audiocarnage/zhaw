

% Serie 11, Aufgabe 7
% Ein Hersteller weiss, dass etwa 3% der gefertigten Bauteile defekt sind. Trotzdem werden 2000
% Teile ausgeliefert. Der Ersatz eines defekten Teils kostet Fr 80.-
% S ist die Summe, die für die Ersatzleistungen aufzubringen ist. Man kalkuliert dafür den Betrag
% B = mu_s + 2 * std_s.
% Binomial verteilt

format compact; format short; clear all; clc;

anteilDefekteBauteile = 0.03;
anzahlAusgelieferteBauteile = 2000;
ersatzteilKosten = 80;

mu_x = anteilDefekteBauteile * anzahlAusgelieferteBauteile
mu_s = mu_x * ersatzteilKosten

varianz_x = anzahlAusgelieferteBauteile * anteilDefekteBauteile * (1-anteilDefekteBauteile)
sigma_x = sqrt(varianz_x)

varianz_s = ersatzteilKosten^2 * sigma_x^2
sigma_s = sqrt(varianz_s)
