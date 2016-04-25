% Script Georgiou_Remi_IT13t_S2_Aufg4
%
% Maschinengenauigkeit auf dem Computersystem bestimmen
% Das Computersystem, d.h. die ALU, rechnet intern nach 
% IEEE754 double precision (64-bit) Standard,
% in anderen Worten im Dualsystem mit 52 signifikanten Nachkommastellen.
% Die Frage ist vielmehr, wie verarbeitet Matlab dieses Ergebnis.
% Die Ausgabe (tau als Ergebnis des Algorithmus) im long-Format
% ist eine Dezimalzahl mit 15 signifikanten Nachkommastellen.
% Zum Vergleich:
% Der gleiche Algorithmus implementiert als Java-Programm liefert
% 1.1102230246251565E-16

format longE;
tau = 1;
while ((tau+1) > 1)
    tau = tau/2;
end
tau