% MANIT3 - Übungserie 1, Aufgabe 2
% Anzahl Insektenstiche auf Äpfeln

format compact; format long; clear all; clc;

h = [83 25 28 18 12 10 2];
x = 0:6;
f = evcdf(x,5,10);

figure('name','MANIT3 - Übung 1 - Aufgabe 2');
subplot(1,2,1);
bar(x,h,'g');
xlabel('x');
ylabel('Anzahl Stiche');
legend('Häufigkeiten','location','NE');

s = cumsum(h)/sum(x);
subplot(1,2,2);
stairs(x,s,'r');
xlabel('x');
ylabel('kumulierte Summe');
legend('Empirische Summenhäufigkeiten','location','NW');

figure('name','MANIT3 - Übung 1 - Aufgabe 2');
boxplot(h);
