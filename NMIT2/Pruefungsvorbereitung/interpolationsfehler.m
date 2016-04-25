% Berechnung der Fehlerabschätzung bei der Lagrange-Interpolation

format compact; format shortE; clear all; clc;

% Parameter
syms x
f = @(x) 2.^x;
xi = [-1 1 3];
yi = [0.5 2 8];
n = numel(xi)-1
fdiff = matlabFunction(diff(f,x,n+1))

% Funktionswert an der Stelle xi
xx = 2;

% pragmatisches Suchen des Funktionsmaximums auf dem Internall [x0,xn]
xii = linspace(xi(1), xi(n+1));
fdiffMax = max(abs(fdiff(xii)))

figure;
plot(xii,f(xii),xii,fdiff(xii));
xlabel('x');
ylabel('y');
legend(sprintf('Funktion %s', func2str(f)),sprintf('(n+1)-te Ableitung %s',func2str(fdiff)),'location','best');
grid on;

% der Interpolationfehler ist grösser gleich |f(x)-pn(x)|
err = abs((xx-xi(1)) * (xx-xi(2)) * (xx-xi(3))) / factorial(n+1) * fdiffMax 
