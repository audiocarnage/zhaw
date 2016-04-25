% FACTORIAL   y = factorial(n) berechnet die Fakultät von n
% factorial(n) = n * factorial(n-1), factorial(0) = 1
% Fehler, falls n < 0 oder nicht ganzzahlig

function[y] = factorial(n)

if n < 0 || fix(n) ~= n,
    error('ERROR: Fakultät ist nur für nicht-negative, ganze Zahlen definiert')
end

if n <= 1,
    y = 1;
else
    y = n * factorial(n-1);
end

end