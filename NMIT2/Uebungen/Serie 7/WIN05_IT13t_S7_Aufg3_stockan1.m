% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 7, Aufgabe 3
% Fehler und Laufzeiten Vergleich von Adams-Bashforth Methode 4. Ordnung  und dem klassischen Runge-Kutta Verfahren

clc; clear all; format shortE; format compact;

f = @(x,y) exp(x); a = 0; b = 1; y0 = 1; i = 1;
nV = logspace(1,6,6);
for n = nV
    t1 = tic; [yRk, x] = WIN05_IT13t_S6_Aufg1_stockan1(f, a, b, n, y0);  tRk(i) = toc(t1);
    t1 = tic; yAb4 = WIN05_IT13t_S7_Aufg2_stockan1(f, a, b, n, y0);  tAb4(i) = toc(t1);
    globErrYRk(i) = abs(yRk(length(x)) - f(x(length(x))));
    globErrYAb4(i) = abs(yAb4(length(x)) - f(x(length(x))));
    i = i+1;
end

subplot(1,2,1);
loglog(nV, globErrYRk, nV, globErrYAb4);

subplot(1,2,2);
plot(nV, tRk, nV, tAb4);


