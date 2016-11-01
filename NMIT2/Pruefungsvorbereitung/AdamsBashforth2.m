% @author Rémi Georgiou (georgrem)
% Adams-Bashforth Methode 2. Ordnung zum Lösen von DGL 1. Ordnung
% Beispiel: [x_ab2,y_ab2] = AdamsBashforth2(@(t,y) t.^(2) + 0.1*y,-1.5,1.5,25,0)

function[x_ab2,y_ab2] = AdamsBashforth2(f,a,b,n,y0)
    
    h = (b-a)/n;  
    
    % Einzelschrittverfahren zur Berechnung des ersten Punktes
    [x_ab2,y_ab2] = RungeKutta4(f,a,a+h,1,y0);
    
    for i=2:n
        x_ab2(i+1) = x_ab2(i) + h;
        y_ab2(i+1) = y_ab2(i) + h/2 .* (3.*f(x_ab2(i), y_ab2(i)) - f(x_ab2(i-1), y_ab2(i-1)));
    end
    
    disp('Adams-Bashforth Methode 2. Ordnung')
    fprintf('xi \t\t\t\t\t yi \n')
    disp([x_ab2' y_ab2'])
end