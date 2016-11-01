% NMIT2 - Serie 6, Aufgabe 2
% @author Rémi Georgiou (geogrem), André Stocker (stockan1)

format compact; format shortE; clc;

% Parameter
R = 4;
r = 0.02;
h0 = 6.5;
g = 9.81;
a = 0;
b = 24e3;
deltaT = 4000;
n = (b-a) / deltaT;

% DGL Wassertankhöhe h=h(t)
f=@(t,h) -(r^2 * sqrt(2*g*h)) / ((2*h*R) - h^2);

% Berechnung y(x) mit Runge-Kutta 4
[t,y_RK4] = WIN05_IT13t_S6_Aufg1(f,a,b,n,h0);
% Berechnung y(x) mit Euler-Verfahren, Mittelpunktsregel und Mod. Euler-Verfahren
[t,y_euler,y_mittelpunkt,y_modeuler] = WIN05_IT13t_S5_Aufg3(f,a,b,n,h0);

figure('name','NMIT2 - Serie 6, Aufgabe 2');
plot(t,y_RK4,'b',t,y_euler,'g',t,y_mittelpunkt,'r',t,y_modeuler,'k');
title(sprintf('DGL %s', func2str(f)));
grid on;
xlabel('t [s]');
ylabel('Höhe [m]');
legend('Runge-Kutta 4','Euler-Verfahren','Mittelpunktsregel',...
    'Mod. Euler-Verfahren','Location','NE');
