% MANIT3 - Übungserie 1, Aufgabe 5

format compact
clear median
clear mittelwert
clc

x = 0:6
hi = [83 25 28 18 12 10 2]


hi_sorted = sort(hi)

mean(hi)
modus = 0
median = prctile(hi_sorted, 50)
