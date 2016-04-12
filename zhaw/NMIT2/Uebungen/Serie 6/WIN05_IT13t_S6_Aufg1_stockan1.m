% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 6, Aufgabe 1
% Das klassische vierstufige Runge-Kutta Verfahren
% Beispiel: [y, x] = WIN05_IT13t_S6_Aufg1_stockan1(@(x,y) x^2 + 0.1 * y, -1.5, 1.5, 5, 0)

function [y, x] = WIN05_IT13t_S6_Aufg1_stockan1(f, a, b, n, y0)
    clc; format shortE; format compact;
    h = (b-a) /n;
    x0 = a;

    x(1) = x0; y(1) = y0;
    for i=1:n
        x(i+1) = x(i) + h;
        k1 = f(x(i), y(i));
        k2 = f(x(i)+(h/2), y(i)+(h/2)*k1);
        k3 = f(x(i)+(h/2), y(i)+(h/2)*k2);
        k4 = f(x(i)+h, y(i)+h*k3);
        y(i+1) = y(i) + h*(1/6)*(k1+2*k2+2*k3+k4);
    end
end