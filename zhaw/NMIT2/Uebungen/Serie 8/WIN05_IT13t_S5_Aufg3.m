% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 5, Aufgabe 3
% Anfangswertproblem
% Beispiel: [x,y_euler,y_mittelpunkt,y_modeuler] = WIN05_IT13t_S5_Aufg3(@(x,y) (x.^2).*(y.^(-1)),0.3,2.4,3,2)

function[x,y_euler,y_mittelpunkt,y_modeuler] = WIN05_IT13t_S5_Aufg3(f,a,b,n,y0)
    h = (b-a)/n;
    x0 = a;
    x(1) = x0;

	y_euler = euler();
	y_mittelpunkt = mittelpunkt();
    y_modeuler = modeuler();

    % Euler-Verfahren
    function[y_euler] = euler()
        y_euler(1) = y0;
        for i=0:n-1
            x(i+2) = x(i+1) + h;
            y_euler(i+2) = y_euler(i+1) + h * f(x(i+1),y_euler(i+1));
        end
    end

    % Mittelpunkt-Verfahren
    function[y_mittelpunkt] = mittelpunkt()
        y_mittelpunkt(1) = y0; y_h_2 = 0;
        for i=0:n-1
            x(i+2) = x(i+1) + h;
            x_h_2(i+1) = x(i+1) + (h/2);
            y_h_2(i+1) = y_mittelpunkt(i+1) + (h/2) * f(x(i+1),y_mittelpunkt(i+1));
            y_mittelpunkt(i+2) = y_mittelpunkt(i+1) + h * f(x_h_2(i+1),y_h_2(i+1));
        end
    end

    % Modifiziertes Euler-Verfahren
    function[y_modeuler] = modeuler()
        y_modeuler(1) = y0;
        y_Euler = 0;
        k1 = 0;
        k2 = 0;
        for i=0:n-1
            x(i+2) = x(i+1) + h;
            y_Euler(i+1) = y_modeuler(i+1) + h * f(x(i+1),y_modeuler(i+1));
            k1 = f(x(i+1),y_modeuler(i+1));
            k2 = f(x(i+2),y_Euler(i+1));
            y_modeuler(i+2) = y_modeuler(i+1) + h * (k1+k2)/2;
        end
    end

end