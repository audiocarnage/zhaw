% NMIT2 - Serie 6, Aufgabe 1
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Anfangswertproblem gelöst mit dem vierstufigen Runge-Kutta Verfahren
% Beispiel: [x,y] = WIN05_IT13t_S6_Aufg1(@(x,y) x^2 + 0.1*y,-1.5,1.5,5,0)

function[x,y] = WIN05_IT13t_S6_Aufg1(f,a,b,n,y0)

    [k,m] = size(y0);
    h = (b-a)/n;
    x = zeros(1,n+1);
    y = zeros(k,n+1);
    x(1) = a;
    y(:,1) = y0;

    for i=1:n
       k1 = f(x(i),y(:,i));
       k2 = f(x(i) + (h/2),y(:,i) + (h.*k1/2));
       k3 = f(x(i) + (h/2),y(:,i)+ (h.*k2/2));
       k4 = f(x(i) + h,y(:,i) + (h.*k3));
       x(i+1) = x(i) + h;
       y(:,i+1) = y(:,i) + (h/6.*(k1+(2.*k2)+(2.*k3)+k4));
    end
end
