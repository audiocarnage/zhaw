% NMIT2 - Serie 1, Aufgabe 2
% @author Georgiou Rémi (georgrem), Stocker André (stockan1)
% Vergleich von Diskretisierungsfehler bei der Anwendung von
% Differenzenformeln.
% Vorwärtsdifferenz D1f: mit h = 1E-8 ist der Fehler für D1f am kleinsten.
% Zentrale Differenz D2f: Mit h = 10^-5 ist der Fehler für D2 am kleinsten.
    
format compact; format shortE; clear all; clc;
    
syms x;
x0 = 2;
f = @(x) log(x^2);
dx = matlabFunction(diff(f,x));
dx_eval = (feval(dx, x0));

% Vorwärtsdifferenz
fprintf('h \t\t\t\t D1f \t\t\t abs_err_D1f \n')
for i=1:17
    h = 10^(-i);
    D1f_eval = (f(x0+h) - f(x0)) / h;
    abs_err_D1f = abs(D1f_eval - dx_eval);
    fprintf('%e \t %.8f \t %e \n', h, D1f_eval, abs_err_D1f);
end

% zentrale Differenz
fprintf('\nh \t\t\t\t D2f \t\t\t\t abs_err_D2f \n')
for i=1:17
    h = 10^(-i);
    D2f_eval = (f(x0+h) - f(x0-h)) / (2*h);
    abs_err_D2f = abs(D2f_eval - dx_eval);
    fprintf('%e \t %.12f \t %e \n', h, D2f_eval, abs_err_D2f);
end
fprintf('\n')
    
% Berechnung der optimal Schrittweite für D1f
f_eval = (feval(f, x0));
ddx = matlabFunction(diff(dx,x));
ddx_eval = (feval(ddx, x0));
h_optD1 = sqrt(4*eps*(abs(f_eval)/abs(ddx_eval)))
% h_opt etspricht der Erwartung gemäss Tabelle.

% Berechnung der optimal Schrittweite für D2f
dddx = matlabFunction(diff(ddx, x));
dddx_eval = (feval(dddx, x0));
h_optD2 = (6*eps*(abs(f_eval)/abs(dddx_eval)))^(1/3)
% h_opt etspricht der Erwartung gemäss Tabelle.
