% MANIT3 - Übungserie 1, Aufgabe 8

format compact; format short; clear all; clc;

% a)
U = [0 4 4 4 1 4 2 4 3 11 6 4 4 1 4 2];
T = [0 4 233 5 4 197 5 231 285 278 39 62 33 1 239 166];

x = min(U):max(U);

figure('name','MANIT3 - Übungsserie 1, Aufgabe 8');
f = hist(U,x);
hist(f);

% b)
U = sort(U);
T = sort(T);
Nu = length(U);
Nt = length(T);

meanU = sum(U)/Nu
meanT = sum(T)/Nt

ku = 0.5 * Nu
if (ceil(ku) == ku)
    medianU = 0.5 * (U(ku) + U(ku+1))
else
    median = U(ku)
end

kt = 0.5 * Nt
if (ceil(kt) == kt)
    medianT = 0.5 * (T(kt) + T(kt+1))
else
    medianT = T(kt)
end
