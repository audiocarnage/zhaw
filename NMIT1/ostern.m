% Y = Yahr
% Beispielaufruf: [d,m,Y] = ostern(2016)
% OSTERN   y = ostern(Y) berechnet das Osterdatum

function [d,m,Year] = ostern(Year)

    format compact; format short; clc;

    B = 225-11 * mod(Year, 19);
    D = mod((B-21), 30) + 21;
    if D > 48,
        D = D-1;
    end
    E = mod((Year + floor(Year/4) + D + 1), 7);
    Q = D + 7 - E;
    d = Q;
    m = 3;
    if Q > 31,
        d = Q-31;
        m = 4;
    end
end