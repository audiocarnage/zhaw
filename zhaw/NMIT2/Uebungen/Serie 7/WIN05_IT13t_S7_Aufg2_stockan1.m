% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 7, Aufgabe 2
% Adams-Bashforth Methode 4. Ordnung
% Beispiel: [x, yab4] = WIN05_IT13t_S7_Aufg2_stockan1(@(x,y) exp(x), 0, 1, 10, 1)

function [x, yab4] = WIN05_IT13t_S7_Aufg2_stockan1(f, a, b, n, y0)
    clc; format shortE; format compact;
    
    h = (b-a) /n;
    [yrk, x] = WIN05_IT13t_S6_Aufg1_stockan1(f, a, b, n, y0);
    y(1:4) = yrk(1:4);
    for i=4:n
        y(i+1) = y(i)+(h/24)*(55*f(x(i),y(i))-59*f(x(i-1),y(i-1))+37*f(x(i-2),y(i-2))-9*f(x(i-3),y(i-3)));
    end
    yab4 = y;
end