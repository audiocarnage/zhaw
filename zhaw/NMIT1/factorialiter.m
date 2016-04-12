function y = factorialiter(n)

% y = factorialiter(n) berechnet die Fakult�t von n iterativ
% Fehler, falls n < 0 oder nicht ganzzahlig
% F�r grosse n ist die Ausf�hrungszeit k�rzer als mit 
% einem rekursiven Algorithmus.

if n < 0 | fix(n) ~= n,
    error('ERROR: Fakult�t ist nur f�r nicht-negative, ganze Zahlen definiert')
end

fak = n;
while n > 1,
    fak = fak * (n-1);
    n = n-1;
end
y=fak;
end