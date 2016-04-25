% Maschinengenauigkeit auf dem Computersystem bestimmen
% nach 52 Halbierungen, ausgehend von der Zahl 1, berechnet der Computer
% die Zahl eps := (1 + eps) != 1
% 52 Halbierungen deshalb, weil in 64-Bit Gleitkommaarithmetik 52 Bits f�r
% die Mantisse zur Verf�gung stehen. 1 Bit f�r das Vorzeichen und 11 Bits
% f�r den Exponenten

%eps = 1;
%for i=0:1:10
%    eps = eps/2
%end

eps = 1;
while ((eps+1) > 1)
    eps = eps/2;
end
eps