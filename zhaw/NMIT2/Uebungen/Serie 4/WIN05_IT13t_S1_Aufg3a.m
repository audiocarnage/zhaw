% @author Georgiou R�mi, Stocker Andr�
% Beispiel: [dx] = WIN05_IT13t_S1_Aufg3a([1 2 3 4],[1 2 3 4])

function[dx] = WIN05_IT13t_S1_Aufg3a(x,y)

if (length(x) ~= length(y))
    error('Vector dimensions do not agree');
end

n = length(x);
dx = [];

if (n > 1)
    %Vorw�rtsdifferenz
    dx = [dx abs((y(2)-y(1)) / (x(2)-x(1)))];
    
    %Zentrale Differenz
    for i=2:n-1
        dx = [dx abs((y(i+1)-y(i-1)) / (x(i+1)-x(i-1)))];
    end

    %R�ckw�rtsdifferenz
    dx = [dx abs((y(n)-y(n-1)) / (x(n)-x(n-1)))];
end
end