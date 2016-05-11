% Beispiel aus dem Script

format compact; format short; clear all; clc;

dichte = [2.8 2.9 3.0 3.1 3.2 3.2 3.2 3.3 3.4];
fe_gehalt = [27 23 30 28 30 32 34 33 30];

figure;
subplot(1,2,1);
plot(dichte,fe_gehalt,'bo','LineWidth',2);
title('Modell');
xlabel('Dichte');
ylabel('Fe-Gehalt [%]');
lsline;
grid on;

n = length(dichte);
dichte = dichte';
fe_gehalt = fe_gehalt';

x = [dichte ones(n,1)];

% Y-Abschnitt und Steigung der Regressionsgeraden
b = regress(fe_gehalt,x);
% Falls die Vektorkomponenten von x vertauscht werden, müssen die 
% Elemente von b ebenfalls umgedreht werden.
Steigung = b(1)
yAchsenabschnitt = b(2)

% Residuen berechnen
e = fe_gehalt-(x*b);

% Residuen haben keinen Einfluss auf den Fe-Gehalt
% Residuen haben den Durchschnitt 0
subplot(1,2,2);
plot(dichte,e,'ro','LineWidth',2);
title('Residuen');
xlabel('Dichte');
ylabel('e');
lsline;
grid on;

% Fehlerquadrat
e2 = e'*e
