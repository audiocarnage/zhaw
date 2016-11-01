% Script Georgiou_Remi_IT13t_S5_Aufg1
%
% a)
% Bei der ersten Nullstelle x1 im Intervall [-1,0] konvergiert die 
% Fixpunktiteration gegen -0.040592.
% Bei der zweiten Nullstelle x2 im Intervall [0,1] handelt es sich um 
% einen abstossenden Fixpunkt, weil |F'(x2)| > 1
% |F'(0.962398)| = 4.01543 > 1
% 
% b)
% Es muss gelten:  (abs(F(x)-F(y)) / abs(x-y))  <= alpha
% alpha ist die grösstmögliche Steigung von F(x) im Intervall [-0.5,0.5]
% F'(x) plotten im Intervall [-0.5,0.5]
% F'(x) wird maximal bei 0.5
% Lipschitz-Konstante alpha = max(x0 in [-0.5,0.5]) |F'(x0)|
% alpha = F'(0.5) = 0.62217
% 
% c)
% à priori Fehlerabschätzung:
% 1e-9 <= (alpha^n/(1-alpha)) * |x1-x0|
% n >= log_alpha((1-alpha) * 10^(-9) / |x1-x0|)
% Mit Startwert x0 = -0.25 musste das Programm 7 Mal iterieren für eine
% Toleranz < 1e-9.

format compact; format long; clear all; clc;

% a)
% Fixpunktgleichung
%F = @(x) (230*x.^4 + 18*x.^3 + 18*x.^2 - 9)/221;
F = @(x) 1./(2.*sin(3./(4.*x)));
%F = @(x) cos(x);

% Nullstelle im Intervall [-1,0]
% Startwert
%x(1) = -0.25;
x(1) = -0.5;

% Toleranz
tol = 1e-6;

abs_err = 2*tol;
n = 0;
while (abs_err > tol)
    n = n+1;
    x(n+1) = F(x(n));
    abs_err = abs(x(n+1) - x(n));
end
x1 = x(length(x))
n
abs_err
clear x n abs_err;

% Nullstelle im Intervall [0,1]
% Startwert
x(1) = 1.2;

abs_err = 2*tol;
n = 0;
while (abs_err > tol)
    n = n+1;
    x(n+1) = F(x(n));
    abs_err = abs(x(n+1) - x(n));
end
x2 = x(length(x))
n
abs_err
clear x n abs_err;

% b)
clear F;
x = linspace(-0.5,0.5);
F = (230*x.^4 + 18*x.^3 + 18*x.^2 - 9)/221;
Fdiff = 920*x.^(3)/221 + 54*x.^(2)/221 + 18*x./221;

figure('Name','Serie 5 - Aufgabe 1,b)');
line1 = plot(x,F,'r','LineWidth',1.5);
hold on;
line2 = plot(x,Fdiff,'b','LineWidth',2.5);

xlabel('x');
ylabel('y');
legend([line1, line2],'F(x) = 230x^4 + 18x^3 + 9x^2 - 9',...
    'F''(x) = 920x^3/221 + 54x^2/221 + 18x/221',...
    'Location','northoutside');
grid on;
hold off;

Fdiff = @(x) 920*x.^(3)/221 + 54*x.^(2)/221 + 18*x./221;
alpha = Fdiff(0.5)


% c)
clear x F;
% Fixpunktgleichung
F = @(x) (230*x.^4 + 18*x.^3 + 18*x.^2 - 9)/221;
% Nullstelle im Intervall [-1,0]
% F'(x) erreicht grösste Steigung bei x = -1
alpha = Fdiff(-1);
% Startwert
x(1) = -0.25;
% Toleranz
tol = 1e-9;
% nach einer Iteration
x(2) = F(x(1));
syms n
s = solve(tol <= (alpha^(n) * abs(x(2)-x(1))) / (1-alpha), n)
