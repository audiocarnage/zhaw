% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Numerische Differentiation:
% Algorithmus für die h-Extrapolation
% Erzeugung einer Differenzenformel höherer Ordnung
% Berechnet Näherung für eine Differenzenformel D mit der Fehlerordnung k+1
% (k=1,...,n)

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
D1f = @(x0,h) (f(x0+h)-f(x0)) / h;

d = zeros(n+1);
error = zeros(n+1);

for i=0:n
    d(i+1,1) = D1f(x0,h0/(2^i));
    error(i+1,1) = abs(d(i+1,1) - fdiff_eval);
end
    
for k=1:n
    for i=0:n-k
        d(i+1,k+1) = ((2^(k)*d(i+2,k))-(d(i+1,k)))/(2^(k)-1);
        error(i+1,k+1) = abs(d(i+1,k+1) - fdiff_eval);
    end
end

disp(sprintf('Fehlerordnung -> %d\n', n+1))

fprintf(1, 'h0 \t\t Di0 \t\t\t Di1 \t\t\t Di2 \t\t\t Di3 \t\t\t Ei0 \t\t\t Ei1 \t\t\t Ei2 \t\t\t Ei3 \n')
for i=1:length(d)
    fprintf('%.4f \t %e \t %e \t %e \t %e \t %e \t %e \t %e \t %e \n',h0/2^(i-1),d(i,1),d(i,2),d(i,3),d(i,4),error(i,1),error(i,2),error(i,3),error(i,4));
end

d
error
D = d(1,n+1)
