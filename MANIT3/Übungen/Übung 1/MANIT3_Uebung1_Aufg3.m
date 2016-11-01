% MANIT3 - �bungserie 1, Aufgabe 3
% Bei einer Firma werden in einem Monat 400 Lebensversicherungsvertr�ge 
% abgeschlossen. Nachstehend ist die klassifizierte H�ufigkeitsverteilung 
% f�r die Versicherungssummen angegeben.

format compact; format shortE; clear all; clc;

xedge = [4 10 20 30 40 80 120];
hi = [20 160 80 40 88 12 0];
N = sum(hi);    % Total Anzahl Vertr�ge
d = hi./[diff(xedge) 1]/N;  % Dichte

figure('name','MANIT3 - �bung 1 - Aufgabe 3');
subplot(1,2,1);
bar(xedge,d,'histc','g');
xlabel('x');
ylabel('Dichte');
legend('H�ufigkeiten','location','best');
grid on;

% Summenkurve
hi_summe = [0 hi(1:length(hi)-1)];
s = cumsum(hi_summe);
F = s/N;
subplot(1,2,2);
plot(xedge,F,'b','LineWidth',2.5);
xlabel('x');
ylabel('F');
legend('relative H�ufigkeit','location','best');
grid on;
