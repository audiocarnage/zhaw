% NMIT2 - Serie 1, Aufgabe 3 a)
% @author Georgiou Rémi, Stocker André
% Beispiel: [dx] = WIN05_IT13t_S1_Aufg3a([1 2 3 4],[2 4 6 8])

function[dx] = WIN05_IT13t_S1_Aufg3a(x,y)

format compact; format short; clc;

if (length(x) ~= length(y))
    error('Vector dimensions do not agree.')
end

n = length(x);
dx = zeros(1,n);

if (n > 1)
    % Vorwärtsdifferenz
    hvor = (x(2)-x(1))
    dx(1) = (y(2)-y(1)) / hvor;
    
    % Zentrale Differenz
    for i=2:n-1
        hzentral = (x(i+1)-x(i-1))
        dx(i) = (y(i+1)-y(i-1)) / hzentral;
    end

    % Rückwärtsdifferenz
    hrueck = (x(n)-x(n-1))
    dx(n) = (y(n)-y(n-1)) / hrueck;
end

end