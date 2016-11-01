% MANIT3 - Übungserie 1, Aufgabe 6

format compact
clc

hi = [2.1 2.4 2.8 3.1 4.2 4.9 5.1 6.0 6.4 7.3 10.8 12.5 13.0 13.7 14.8 17.6 19.6 23.0 25.0 35.2 39.6];
N = length(hi);

alpha = 0.5;
k = alpha*N;

if (k - floor(k) ~= 0)
	k = ceil(alpha*N);
    median = hi(k)
else
    median = 0.5 * (hi(k) + hi(k+1))
end

mean = sum(hi)/N
standardweichung = std(hi)
