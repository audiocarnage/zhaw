% NMIT2 - Kapitel 9 Zusatzaufgabe

format compact; format short; clear all; clc;

% Datenpunkte
xi = 1:6;
yi = [1 5 8 17 24 37]';

% Ansatzfunktionen
f1 = xi.^2;
f2 = cos(xi);
f3 = sin(xi);

A = [f1' f2' f3'];

% Normalgleichungssystem auflösen nach lambda
lambda = (A'*A)\(A'*yi);

disp('Lösung des Normalgleichungssystems - Parameter des Ausgleichsproblem')
a = lambda(1)
b = lambda(2)
c = lambda(3)

f = a*f1 + b*f2 + c*f3;

% Konditionszahl
disp('----- Kondition der Matrix A''*A -----')
Konditionszahl = cond(A'*A)

figure('name','NMIT2 - Kapitel 9, Zusatzaufgabe');
plot(xi,yi,'ro',xi,f,'b','LineWidth',2);
xlabel('x');
ylabel('y');
grid on;
legend('Datenpunkte','eigene Fitfunktion','location','best');
