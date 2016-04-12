% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Euler-Verfahren zum Lösen von DGL 1. Ordnung
% Beispiel: [x_euler,y_euler] = eulerverfahren(@(t,y) t.^(2) + 0.1*y,-1.5,1.5,25,0)

function[x_euler,y_euler] = eulerverfahren(f,a,b,n,y0)
    
    h = (b-a)/n;
    x_euler(1) = a;
    y_euler(1) = y0;
        
    for i=1:n
        x_euler(i+1) = x_euler(i) + h;
        y_euler(i+1) = y_euler(i) + (h .* f(x_euler(i), y_euler(i)));
    end
    
    %disp('Eulerverfahren')
    %fprintf('xi \t\t\t\t\t yi \n')
    %disp([x_euler' y_euler'])
end