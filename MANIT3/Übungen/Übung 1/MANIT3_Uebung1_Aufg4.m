% MANIT3 - Übungserie 1, Aufgabe 4

format compact; format short; clear all; clc;

hiA = [19 24 26 27 10 5];
hiB = [4 8 52 40 32 24];

alphaA = (19 + (0.5 * 24)) / sum(hiA)
alphaB = (4 + 8 + (0.5 * 52)) / sum(hiB)

disp('Springer am weitesten ''unter Form''')
if (alphaA > alphaB)
    fprintf('A -> %.4f', alphaA)
else
    fprintf('B -> %.4f', alphaB)
end
