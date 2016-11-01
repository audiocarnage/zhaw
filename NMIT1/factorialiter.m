function y = factorialiter(n)

% y = factorialiter(n) berechnet die Fakultät von n iterativ
% Fehler, falls n < 0 oder nicht ganzzahlig
% Für grosse n ist die Ausführungszeit kürzer als mit 
% einem rekursiven Algorithmus.

if n < 0 | fix(n) ~= n,
    error('ERROR: Fakultät ist nur für nicht-negative, ganze Zahlen definiert')
end

fak = n;
while n > 1,
    fak = fak * (n-1);
    n = n-1;
end
y=fak;
end