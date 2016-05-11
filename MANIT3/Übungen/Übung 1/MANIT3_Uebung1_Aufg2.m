% MANIT3 - �bungserie 1, Aufgabe 2
% Anzahl Insektenstiche auf �pfeln

format compact; format long; clear all; clc;

h = [83 25 28 18 12 10 2];
x = 0:6;
f = evcdf(x,5,10);

figure('name','MANIT3 - �bung 1 - Aufgabe 2');
subplot(1,2,1);
bar(x,h,'g');
xlabel('x');
ylabel('Anzahl Stiche');
legend('H�ufigkeiten','location','NE');

s = cumsum(h)/sum(x);
subplot(1,2,2);
stairs(x,s,'r');
xlabel('x');
ylabel('kumulierte Summe');
legend('Empirische Summenh�ufigkeiten','location','NW');

figure('name','MANIT3 - �bung 1 - Aufgabe 2');
boxplot(h);
