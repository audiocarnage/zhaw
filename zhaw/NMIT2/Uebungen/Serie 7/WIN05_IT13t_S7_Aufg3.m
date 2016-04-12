% NMIT2 - Serie 7, Aufgabe 3
% Script zum Vergleich der Adams-Bashforth Methode 4. Ordnung
% vs. vierstufiges Runge-Kutta Verfahren
% c) Beobachtungen:
% Wie erwartet ist das Runge Kutta 4 Verfahren bis n=10^4 um einen
% Faktor 100 genauer als das Adams-Bashforth 4 Verfahren.
% Ab n=10^4 sind beide Verfahren gleich genau.
% Die Genauigkeit nimmt bei beiden Verfahren zu bis n=10^5.
% Ab n=10^5 nimmt die Genauigkeit aufgrund von Rundungsfehler wieder ab.

format compact; format shortE; clc; clear all;

% Parameter
f = @(x,y) y;
a = 0;
b = 1;
y0 = 1;
N = 1:8;

for j=N(1):N(length(N))
    n(j) = 10^j;
    
    % Berechnung mit Runge-Kutta 4 Verfahren
    tic;
    [xRK4,yRK4] = WIN05_IT13t_S6_Aufg1(f,a,b,n(j),y0);
    tRK4(j) = toc;
    
    % Adams-Bashforth Methode 4. Ordnung
    tic;
    [xab4,yab4] = WIN05_IT13t_S7_Aufg2(f,a,b,n(j),y0);
    tyab4(j) = toc;
    
    abs_err_RK4(j) = abs(exp(1) - yRK4(length(yRK4)));
    abs_err_AB4(j) = abs(exp(1) - yab4(length(yab4)));
end

figure('name','NMIT2 - Serie 7, Aufgabe 3');
subplot(1,2,1);
loglog(n,abs_err_RK4,n,abs_err_AB4,'LineWidth',1);
title(sprintf('Absoluter Fehler    y''=f(x,y)=%s', func2str(f)));
xlabel('n');
ylabel('absoluter Fehler |y(x_n) - y_n|');
legend('Runge-Kutta 4','Adams-Bashforth 4. Ordnung','Location','NE');
grid on;

subplot(1,2,2);
plot(n,tRK4,n,tyab4);
title('Laufzeit');
xlabel('n');
ylabel('t(n) [s]');
legend('Runge-Kutta 4','Adams-Bashforth 4. Ordnung','Location','NW');
grid on;
