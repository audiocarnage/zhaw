% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 6, Aufgabe 3
% DGL-Verfahren im Vergleich

clc; format shortE; clear all; format compact;
f = @(x,y) (x^2)/y;
F = @(x) sqrt(((2*x.^3)/3) + 4);
a = 0; b = 10; y0 = 2; h = 0.1;
n = (b-a)/h;

[y, x] = WIN05_IT13t_S6_Aufg1_stockan1(f, a, b, n, y0);
[x, y_euler, y_mittelpunkt, y_modeuler] = WIN05_IT13t_S5_Aufg3(f, a, b, n, y0);

subplot(1,2,1);
plot(x,y, x,y_euler, x,y_mittelpunkt, x,y_modeuler);
xlabel('x'); ylabel('y(x)');
legend('Runge-Kutta Verfahren','Eulerverfahren','Mittelpunktverfahren',...
    'modifiziertes Eulerverfahren');
grid on;

yExakt = F(x);
absErrKuta = abs(yExakt - y);
absErrEueler = abs(yExakt - y_euler);
absErrMittelpunkt = abs(yExakt - y_mittelpunkt);
absErrModEuler = abs(yExakt - y_modeuler);

subplot(1,2,2);
semilogy(x,absErrKuta, x,absErrEueler, x,absErrMittelpunkt, x,absErrModEuler);
xlabel('x'); ylabel('log(absErr)');
legend('Runge-Kutta Verfahren','Eulerverfahren','Mittelpunktverfahren',...
    'modifiziertes Eulerverfahren');
grid on;