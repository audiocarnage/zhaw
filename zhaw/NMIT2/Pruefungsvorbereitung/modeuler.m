% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Modifiziertes Eulerverfahren zum Lösen von DGL 1. Ordnung
% Beispiel: [x_modeuler,y_modeuler] = modeuler(@(x,y) x.^(2)./y,0,2.1,3,1.5)

function[x_modeuler,y_modeuler] = modeuler(f,a,b,n,y0)

    h = (b-a)/n;
    x_modeuler(1) = a;
    y_modeuler(1) = y0;
        
    for i=1:n
        x_modeuler(i+1) = x_modeuler(i) + h;
        yeuler = y_modeuler(i) + (h .* f(x_modeuler(i), y_modeuler(i)));
        k1 = f(x_modeuler(i), y_modeuler(i));
        k2 = f(x_modeuler(i+1), yeuler);
        y_modeuler(i+1) = y_modeuler(i) + (h .* ((k1+k2) / 2));
    end
    
    disp('Modifiziertes Eulerverfahren')
    fprintf('xi \t\t\t\t\t yi \n')
    disp([x_modeuler' y_modeuler'])
end