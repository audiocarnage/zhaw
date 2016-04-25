% NMIT2 - Serie 9, Aufgabe 1
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% c) Die Romberg-Extrapolation schneidet in diesem Beispiel besser als
%    die Lagrange-Interpolation ab.

format compact; format shortE; clear all; clc;

xi = [exp(1)-0.5 exp(1)-0.25 exp(1)+0.25 exp(1)+0.5];
y = [3.9203 5.9169 11.3611 14.8550];

syms x;
I = @(x) 2*x*log(x^2);
F = matlabFunction(int(I,x));
n = length(xi)-1;
xn = exp(1);

% b)
% exakter Wert: 
exakt = F(exp(1))-F(1)

disp('-----')

% Näherung berechnet mittels Lagrange-Interpolation
[lagrange] = LagrangeInterpolation(xi,y,exp(1))
abs_error_lagrange = abs(exakt-lagrange)
rel_error_lagrange = (abs_error_lagrange)/exakt

disp('-----')

% Näherung berechnet mit der Romberg-Extrapolation
romberg = WIN05_IT13t_S3_Aufg3(I,1,exp(1),4)
abs_error_romberg = abs(exakt-romberg)
rel_error_romberg = (abs_error_romberg)/exakt

disp('-----')

% Fehlerabschätzung
f = matlabFunction(diff(I,x,n+1));
diffMax = max(f(xi(1)),f(xi(n+1)));
a = 1;
for i=1:n+1
    a = a * (xn - xi(i));
end
obereFehlerSchranke = diffMax * abs(a) / factorial(n+1)
