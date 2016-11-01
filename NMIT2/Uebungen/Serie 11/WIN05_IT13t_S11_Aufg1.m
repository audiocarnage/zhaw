% NMIT2 - Serie 11, Aufgabe 1
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Ausgleichsfunktion p(T) = aT.^2 + bT + c
%
% Lösung des Normalgleichungssystems - Parameter des Ausgleichsproblem
% a = -3.5676e-03, b = -6.9695e-02, c = 1.0005e+03
%
% Die Lösung mit Polyfit ergibt:
% p = [-3.5676e-03 -6.9695e-02 1.0005e+03]
%
% Die Lösungen sind bis auf 12 Nachkommastellen identisch
% abs_error_lambda = [6.2840e-16 6.9278e-14 1.3642e-12]

format compact; format shortE; clear all; clc;

T = [0 10 20 30 40 50 60 70 80 90 100];
rho = [999.9 999.7 998.2 995.7 992.2 988.1 983.2 977.8 971.8 965.3 958.4]';

A = [(T.^2)' T' ones(length(T'),1)];

% Normalgleichungssystem auflösen nach lambda
lambda = (A'*A)\(A'*rho);

disp('Lösung des Normalgleichungssystems - Parameter des Ausgleichsproblem')
a = lambda(1)
b = lambda(2)
c = lambda(3)

% Konditionszahl
% Die Matrix A'*A ist schlecht konditioniert.
disp('----- Kondition der Matrix A''*A -----')
Konditionszahl = cond(A'*A)

figure('name','NMIT2 - Serie 11, Aufgabe 1');
plot(T,rho','b-o','LineWidth',1.5);
title('Wasserdichte in Abhängigkeit der Temperatur');
xlabel('Temperatur [°C]');
ylabel('Dichte \rho [g/l]');
grid on;

% Vergleich mit polyfit
disp('----- Polyfit -----')
[p,S] = polyfit(T,rho',2);
p = p'
disp('----- Differenz lambda - p -----')
abs_error_lambda = abs(lambda-p)
