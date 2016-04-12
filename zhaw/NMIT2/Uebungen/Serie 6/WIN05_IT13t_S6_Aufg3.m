% NMIT2 - Serie 6, Aufgabe 3
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Vergleich von 4 DGL-Lösungsverfahren
% Euler, Mittelpunktsregel, Modifiziertes Eulerverfahren, Runge-Kutta 4

format compact; format shortE; clear all; clc;

% Parameter
a = 0;
b = 10;
y0 = 2;
h = 0.1;
n = (b-a)/h;

% DGL
ydiff_exakt = @(x,y) sqrt(((2*x.^3)/3) + 4);
ydiff = @(x,y) x.^(2)/y;

% Berechnung y(x) mit Runge-Kutta 4
[x_RK4,y_RK4] = WIN05_IT13t_S6_Aufg1(ydiff,a,b,n,y0);
% Berechnung y(x) mit Euler-Verfahren, Mittelpunktsregel und Mod. Euler-Verfahren
[x,y_euler,y_mittelpunkt,y_modeuler] = WIN05_IT13t_S5_Aufg3(ydiff,a,b,n,y0);

% plot DGL-Lösungsvergleich der 4 Verfahren
figure('name','NMIT2 - Serie 6, Aufgabe 3');
subplot(1,2,1);
plot(x,y_RK4,'b','LineWidth',1);
title(sprintf('Vergleich von Lösungsverfahren der DGL %s', func2str(ydiff)));
hold on;
plot(x,y_euler,'g','LineWidth',1);
plot(x,y_mittelpunkt,'r','LineWidth',1);
plot(x,y_modeuler,'k','LineWidth',1);
xlabel('x');
ylabel('y(x)');
grid on;
hold off;
legend('Runge-Kutta 4','Euler-Verfahren','Mittelpunktsregel','Mod. Euler-Verfahren',...
    'Location','NW');

% plot lokale Fehler
subplot(1,2,2);
semilogy(x,abs(ydiff_exakt(x_RK4,y_RK4) - y_RK4),'b');
title(sprintf('Lokaler Fehler der DGL %s', func2str(ydiff)));
hold on;
semilogy(x,abs(ydiff_exakt(x,y_euler) - y_euler),'g');
semilogy(x,abs(ydiff_exakt(x,y_mittelpunkt) - y_mittelpunkt),'r');
semilogy(x,abs(ydiff_exakt(x,y_modeuler) - y_modeuler),'k');
xlabel('x');
ylabel('|y(x_i) - y_i|');
legend('Runge-Kutta 4','Euler-Verfahren','Mittelpunktsregel',...
    'Mod. Euler-Verfahren','Location','SE');
grid on;
hold off;
