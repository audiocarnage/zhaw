% MANIT3 - Übungserie 1, Aufgabe 9

format compact; format short; clear all; clc;

hi = [5 18 15 7 23 220 130 85 103 25 80 7 24 6 13 65 37 25 24 65 82 95 77 ...
        15 70 110 44 28 33 81 29 14 45 92 17 53];

n = length(hi);
mean = sum(hi)/n;

figure;
subplot(2,2,1);
bar(hi,'histc');
xlabel('x');
ylabel('Partikelkonzentration [\mug/m^3]');
legend('Häufigkeiten','location','NE');

x = 0:35;
s = cumsum(hi)/sum(x);
subplot(2,2,2);
stairs(x,s,'r');
xlabel('x');
ylabel('F');
legend('Summenhäufigkeiten Fi','location','NW');

subplot(2,2,3);
boxplot(hi);
xlabel('x');

Mittelwert = mean
Q1 = prctile(hi,25)
prctile(hi,50)
Q3 = prctile(hi,75)

Standardabweichung = sqrt((1/(n-1)) * (sum(hi.^2) - n*(mean^2)))
