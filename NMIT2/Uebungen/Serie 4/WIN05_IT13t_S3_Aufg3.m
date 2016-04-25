% NMIT2 - Serie 3, Aufgabe 3 
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Algorithmus für die Romberg-Extrapolation
% Beispiel: [T] = WIN05_IT13t_S3_Aufg3(@(x) cos(x.^2),0,pi,4)

function [T] = WIN05_IT13t_S3_Aufg3(f,a,b,n)

if (a >= b)
   error('Ungültiges Intervall')
end

t_ii = zeros(n+1);

% Ti0
for i=0:n
    hi = (b-a)/2^i;
    summe = (f(a)+f(b))/2;
    for j=1:2^(i)-1
        f_stuetzstelle = f(a+(j*hi));
        summe = summe + f_stuetzstelle;
    end
    t_ii(i+1,1) = hi*(summe);
end

% Tik
for k=1:n
    for i=0:n-k
        t_ii(i+1,k+1) = ((4^(k)*t_ii(i+2,k))-(t_ii(i+1,k)))/(4^(k)-1);
    end
end

T = t_ii(1,length(t_ii));