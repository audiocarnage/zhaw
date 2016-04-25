% Function Georgiou_Remi_IT13t_S1_Aufg3(n)
% berechnet die Fakult�t von n iterativ
% Fehler, falls n < 0 oder nicht ganzzahlig.
% Beispiel eines Funktionsaufrufes:
% FAK = Georgiou_Remi_IT13t_S1_Aufg3(5)

% F�r grosse n ist die Ausf�hrungszeit k�rzer als mit 
% einem rekursiven Algorithmus.
% Der rekursive Algorithmus ist f�r grosse Eingaben langsamer,
% weil ein Runtime-Stack aufgebaut werden muss,
% damit zum vorhergehenden Funktionsaufruf zur�ckzukehren.

function y = Georgiou_Remi_IT13t_S1_Aufg3(n)

if n < 0 || fix(n) ~= n,
    error('ERROR: Fakult�t ist nur f�r nicht-negative, ganze Zahlen definiert.')
end

y = 1;

% falls n == 0, wird der for-Loop nicht durchlaufen
% und der Funktionswert y bleibt 1.

for i=n:-1:1
    y = y * i;
end
end