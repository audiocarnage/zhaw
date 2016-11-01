% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Numerische Differentiation:
% Algorithmus für die h^2-Extrapolation
% Erzeugung einer Differenzenformel höherer Ordnung nur mit geraden
% Potenzen
% % Berechnet Näherung für eine Differenzenformel D mit der Fehlerordnung
% 2(k+1)   (k=1,...,n)

format compact; format long; clear all; clc;

% Parameter----------------------------------
syms x
f = @(x) sin(x)
fdiff = matlabFunction(diff(f,x))

x0 = 1;
h0 = 0.1;
n = 3;
% -------------------------------------------

fdiff_eval = fdiff(x0);
D2f = @(x0,h) (f(x0+h)-f(x0-h))/(2*h);

d = zeros(n+1);
error = zeros(n+1);

for i=0:n
    d(i+1,1) = D2f(x0,h0/2^i);
    error(i+1,1) = abs(d(i+1,1) - fdiff_eval);
end

for k=1:n
    for i=0:n-k
        d(i+1,k+1) = ((4^(k)*d(i+2,k))-(d(i+1,k)))/(4^(k)-1);
        error(i+1,k+1) = abs(d(i+1,k+1) - fdiff_eval);
    end
end

d
error
D = d(1,n+1)
