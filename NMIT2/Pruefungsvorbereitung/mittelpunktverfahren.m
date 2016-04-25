% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Mittelpunkt-Verfahren zum Lösen von DGL 1. Ordnung
% Beispiel: [x_midpoint,y_midpoint] = mittelpunktverfahren(@(x,y) x.^(2)./y,0,2.1,3,1.5)

function[x_midpoint,y_midpoint] = mittelpunktverfahren(f,a,b,n,y0)
    
    h = (b-a)/n;
    x_midpoint(1) = a;
    y_midpoint(1) = y0;
        
    for i=1:n
        xmitte = x_midpoint(i) + (h/2);
        ymitte = y_midpoint(i) + (h/2 .* f(x_midpoint(i), y_midpoint(i)));
        x_midpoint(i+1) = x_midpoint(i) + h;
        y_midpoint(i+1) = y_midpoint(i) + (h .* f(xmitte, ymitte));
    end
    
    disp('Mittelpunktverfahren')
    fprintf('xi \t\t\t\t\t yi \n')
    disp([x_midpoint' y_midpoint'])
end