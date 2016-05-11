% MANIT3 - Übungsserie 3, Aufgabe 2

format compact
clc

umsatz = [3 8 19 22 31 42 48 52 54]';
mitarbeiter = [2 31 49 65 84 96 117 129 146]';

figure;
subplot(1,2,1);
plot(mitarbeiter,umsatz,'bo','LineWidth',2);
xlabel('Mitarbeiter');
ylabel('Umsatz [in Mio.]');

n = length(mitarbeiter);
x = [ones(n,1) mitarbeiter];

% Y-Abschnitt und Steigung der Regressionsgeraden
b = regress(umsatz,x)

% Umsatz in mio.
umsatz200Mitarbeiter = (b(2)*200) + b(1)

% Residuen berechnen
e = umsatz-(x*b);

% Residuen haben den Durchschnitt 0
subplot(1,2,2);
plot(mitarbeiter,e,'rx','LineWidth',2);
%line([2.7 3.5], [0 0]);
lsline;