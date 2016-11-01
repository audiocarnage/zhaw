% NMIT2 - Serie 3, Aufgabe 3 
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Romberg-Extrapolation Algorithmus
% Beispiel: [T] = WIN05_IT13t_S3_Aufg3(@(x) 2*x*log(x^2),1,exp(1),4)

function [T] = WIN05_IT13t_S3_Aufg3(f,a,b,n)

    if (a >= b)
       error('Ungültiges Intervall')
    end

    syms x
    F = matlabFunction(int(f,x));

    F_eval = F(b);

    t = zeros(n+1);
    err = zeros(n+1);

    % Ti0
    for i=0:n
        hi = (b-a)/2^i;
        summe = (f(a)+f(b))/2;
        for j=1:2^(i)-1
            f_stuetzstelle = f(a+(j*hi));
            summe = summe + f_stuetzstelle;
        end
        t(i+1,1) = hi*(summe);
        err(i+1,1) = abs(t(i+1,1) - F_eval);
    end

    % Tik
    for k=1:n
        for i=0:n-k
            t(i+1,k+1) = ((4^(k)*t(i+2,k))-(t(i+1,k)))/(4^(k)-1);
            err(i+1,k+1) = abs(t(i+1,k+1) - F_eval);
        end
    end

    T = t(1,length(t));
end