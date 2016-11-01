% MANIT3 - Übungsserie 2, Aufgabe6

format compact
clc

x = [3 7 11 4]

mittelwertX = mean(x)
StandardabweichungX = std(x)

z = (x-mean(x))/std(x)
mittelwertZ = mean(z)

z = (z-mean(z))/std(z)
