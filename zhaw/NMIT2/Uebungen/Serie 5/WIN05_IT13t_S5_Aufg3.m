% NMIT2 - Serie 5, Aufgabe 3
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Beispiel: [x,y_euler,y_midpoint,y_modeuler] = WIN05_IT13t_S5_Aufg3(@(x,y) x.^(2)./y,0,2.1,3,1.5)

function [x,y_euler,y_midpoint,y_modeuler] = WIN05_IT13t_S5_Aufg3(f,a,b,n,y0)

    format compact; format shortE; clc;
    
    h = (b-a)/n;

    [x_euler, y_euler] = euler(f,a,b,n,y0);
    [x_midpoint, y_midpoint] = midpoint(f,a,b,n,y0);
    [x_modeuler, y_modeuler] = modeuler(f,a,b,n,y0);
    x = x_euler;

    figure('name','NMIT2 - Serie 5, Aufgabe 3');
    WIN05_IT13t_S5_Aufg1(f,a,b,a,b,h,h);
    hold on;
    plot(x,y_euler,x,y_midpoint,x,y_modeuler);
    hold off;
    xlim auto;
    ylim auto;
    xlabel('x');
    ylabel('y(x)');
    legend('Richtungsfeld','Klassisches Eulerverfahren',...
        'Mittelpunktverfahren','Modifiziertes Eulerverfahren',...
        'Location','NW');
    grid on;

    
    function [x_euler, y_euler] = euler(f,a,b,n,y0)
        
        x_euler(1) = a;
        y_euler(1) = y0;
        
        for i=1:n
            x_euler(i+1) = x_euler(i) + h;
            y_euler(i+1) = y_euler(i) + (h .* f(x_euler(i), y_euler(i)));
        end
    end
    

    function [x_midpoint, y_midpoint] = midpoint(f,a,b,n,y0)
        
        x_midpoint(1) = a;
        y_midpoint(1) = y0;
        
        for i=1:n
            xmitte = x_midpoint(i) + (h/2);
            ymitte = y_midpoint(i) + (h/2 .* f(x_midpoint(i), y_midpoint(i)));
            x_midpoint(i+1) = x_midpoint(i) + h;
            y_midpoint(i+1) = y_midpoint(i) + (h .* f(xmitte, ymitte));
        end
    end

    function [x_modeuler, y_modeuler] = modeuler(f,a,b,n,y0)

        x_modeuler(1) = a;
        y_modeuler(1) = y0;
        
        for i=1:n
            x_modeuler(i+1) = x_modeuler(i) + h;
            yeuler = y_modeuler(i) + (h .* f(x_modeuler(i), y_modeuler(i)));
            k1 = f(x_modeuler(i), y_modeuler(i));
            k2 = f(x_modeuler(i+1), yeuler);
            x_modeuler(i+1) = x_modeuler(i) + h;
            y_modeuler(i+1) = y_modeuler(i) + (h .* ((k1+k2) / 2));
        end
    end

end