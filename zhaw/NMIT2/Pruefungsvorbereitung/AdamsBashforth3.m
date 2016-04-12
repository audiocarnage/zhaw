% @author Rémi Georgiou (georgrem)
% Adams-Bashforth Methode 3. Ordnung zum Lösen von DGL 1. Ordnung
% Beispiel: [x_ab3,y_ab3] = AdamsBashforth3(@(t,y) t.^(2) + 0.1*y,-1.5,1.5,25,0)

function[x_ab3,y_ab3] = AdamsBashforth3(f,a,b,n,y0)
    
    h = (b-a)/n;  
    
    % Einzelschrittverfahren zur Berechnung der ersten zwei Punkte
    [x_ab3,y_ab3] = RungeKutta4(f,a,a+(2*h),2,y0);
    
    for i=3:n
        x_ab3(i+1) = x_ab3(i) + h;
        y_ab3(i+1) = y_ab3(i) + h/12 .* (23.*f(x_ab3(i), y_ab3(i)) ...
            - 16.*f(x_ab3(i-1), y_ab3(i-1)) + 5.*f(x_ab3(i-2), y_ab3(i-2)));
    end
    
    disp('Adams-Bashforth Methode 3. Ordnung')
    fprintf('xi \t\t\t\t\t yi \n')
    disp([x_ab3' y_ab3'])
end