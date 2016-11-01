% @author Rémi Georgiou (georgrem)
% Adams-Bashforth Methode 4. Ordnung zum Lösen von DGL 1. Ordnung
% Beispiel: [x_ab4,y_ab4] = AdamsBashforth4(@(t,y) t.^(2) + 0.1*y,-1.5,1.5,25,0)

function[x_ab4,y_ab4] = AdamsBashforth4(f,a,b,n,y0)
    
    h = (b-a)/n;  
    
    % Einzelschrittverfahren zur Berechnung der ersten drei Punkte
    [x_ab4,y_ab4] = RungeKutta4(f,a,a+(3*h),3,y0);
    
    for i=4:n
        x_ab4(i+1) = x_ab4(i) + h;
        y_ab4(i+1) = y_ab4(i) + h/24 .* (55.*f(x_ab4(i), y_ab4(i)) ...
            - 59.*f(x_ab4(i-1), y_ab4(i-1)) + 37.*f(x_ab4(i-2), y_ab4(i-2)) ...
            - 9.*f(x_ab4(i-3), y_ab4(i-3)));
    end
    
    disp('Adams-Bashforth Methode 4. Ordnung')
    fprintf('xi \t\t\t\t\t yi \n')
    disp([x_ab4' y_ab4'])
end