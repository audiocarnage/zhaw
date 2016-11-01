% NMIT2 - Serie 7, Aufgabe 1
% Script Adams-Bashforth Methode 4. Ordnung herleiten

format compact; format rat; clear all; clc;

% Berechnung der Gewichte gemäss Formel im Skript
s = 3;
j = 0:s;
n = 4;

factor = (-1).^(j) ./ (factorial(j) .* factorial(s-j));

syms u;
f(1) = (u+1)*(u+2)*(u+3);
f(2) = (u+0)*(u+2)*(u+3);
f(3) = (u+0)*(u+1)*(u+3);
f(4) = (u+0)*(u+1)*(u+2);

for i=0:s
    T = WIN05_IT13t_S3_Aufg3(matlabFunction(f(i+1)),0,1,n)
    b(i+1) = factor(i+1) * T;
end

disp('Koeffizienten:');
b
