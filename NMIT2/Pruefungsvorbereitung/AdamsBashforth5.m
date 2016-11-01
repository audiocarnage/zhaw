% @author Rémi Georgiou (georgrem)
% Adams-Bashforth Methode 5. Ordnung zum Lösen von DGL 1. Ordnung
% Beispiel: [x_ab5,y_ab5] = AdamsBashforth5(@(t,y) t.^(2) + 0.1*y,-1.5,1.5,25,0)

function[x_ab5,y_ab5] = AdamsBashforth5(f,a,b,n,y0)
    
    h = (b-a)/n;  
    
    % Einzelschrittverfahren zur Berechnung der ersten vier Punkte
    [x_ab5,y_ab5] = RungeKutta4(f,a,a+(4*h),4,y0);
    
    for i=5:n
        x_ab5(i+1) = x_ab5(i) + h;
        y_ab5(i+1) = y_ab5(i) + h .* (1901/720.*f(x_ab5(i), y_ab5(i)) ...
            - 1387/360.*f(x_ab5(i-1), y_ab5(i-1)) + 109/30.*f(x_ab5(i-2), y_ab5(i-2)) ...
            - 637/360.*f(x_ab5(i-3), y_ab5(i-3)) + 251/720.*f(x_ab5(i-4), y_ab5(i-4)));
    end
    
    disp('Adams-Bashforth Methode 5. Ordnung')
    fprintf('xi \t\t\t\t\t yi \n')
    disp([x_ab5' y_ab5'])
end