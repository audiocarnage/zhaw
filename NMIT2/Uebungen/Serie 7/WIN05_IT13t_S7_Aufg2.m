% NMIT2 - Serie 7, Aufgabe 2
% Funktion Adams-Bashforth Methode 4. Ordnung
% Beispiel: [x,yab4] = WIN05_IT13t_S7_Aufg2(@(x,y) y,0,1,10,1)

function[x,yab4] = WIN05_IT13t_S7_Aufg2(f,a,b,n,y0)

    format shortE; format compact;

    % Parameter
    h = (b-a)/n;
    bRK4 = a + (4*h);

    % Berechnung mit Runge-Kutta 4 Verfahren
    [x_RK4,y_RK4] = WIN05_IT13t_S6_Aufg1(f,a,bRK4,4,y0);
    
    x = x_RK4(1:4);
    yab4 = y_RK4(1:4);
    
    for i=4:n
        x(i+1) = x(i) + h;
        yab4(i+1) = yab4(i) + (h/24) * (55*f(x(i),yab4(i)) - 59*f(x(i-1),yab4(i-1)) + 37*f(x(i-2),yab4(i-2)) - 9*f(x(i-3),yab4(i-3)));
    end
    
end