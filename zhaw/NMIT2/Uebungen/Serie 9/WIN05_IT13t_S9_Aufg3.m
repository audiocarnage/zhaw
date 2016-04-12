% NMIT2 - Serie 9, Aufgabe 3
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Implementation des Aitken-Neville Schema
% Beispiel: [yj] = WIN05_IT13t_S9_Aufg3([0 2500 5000 10000],[1013 747 540 226],1250)

function[yj] = WIN05_IT13t_S9_Aufg3(x,y,xj)
    
    format compact; format short; clc;

    if (length(x) ~= length(y))
       error('Dimensions must agree.') 
    end
    
    n = length(x)-1;
    
    pnn = zeros(n+1,length(x));
    for i=1:n+1
        pnn(i,1) = y(i)
        for j=2:i
            pnn(i,j) = (((x(i)-xj)*pnn(i-1,j-1)) + ((xj-x(i-j+1))*pnn(i,j-1))) / (x(i)-x(i-j+1))
        end
    end
    yj = pnn(n+1,n+1);
end