% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 6, Aufgabe 3
% DGL-Verfahren im Vergleich

clc; format shortE; clear all; format compact;
R = 4; r = 0.02; g = 9.81;
f = @(t,h) -((r^2)*sqrt(2*g*h))/(2*h*R-h^2);
a = 0; b = 24000; h0 = 6.5; deltaT = 4000;
n = (b-a)/deltaT;
[y, x] = WIN05_IT13t_S6_Aufg1_stockan1(f, a, b, n, h0)
[x, y_euler, y_mittelpunkt, y_modeuler] = WIN05_IT13t_S5_Aufg3(f, a, b, n, h0)

plot(x,y, x,y_euler, x,y_mittelpunkt, x,y_modeuler);
xlabel('x'); ylabel('y(x)');
legend('Runge-Kutta Verfahren','Eulerverfahren','Mittelpunktverfahren',...
    'modifiziertes Eulerverfahren');
grid on;