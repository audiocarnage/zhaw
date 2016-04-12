% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 5, Aufgabe 3
% Anfangswertproblem
% Beispiel: [x,y_euler,y_mittelpunkt,y_modeuler] = WIN05_IT13t_S5_Aufg3(@(x,y) (x.^2).*(y.^(-1)),0.3,2.4,3,2)

function [x, y_euler, y_mittelpunkt, y_modeuler] = WIN05_IT13t_S5_Aufg3(f, a, b, n, y0)
    clc; format short; format compact;
    
    h = (b-a)/n;
    x0 = 0;
    x(1) = x0;

    % Euler-Verfahren
    y_euler(1) = y0;
    for i=0:n-1
        x(i+2) = x(i+1) + h;
        y_euler(i+2) = y_euler(i+1) + h * f(x(i+1),y_euler(i+1));
    end

    % Mittelpunkt-Verfahren
    y_mittelpunkt(1) = y0; y_h_2 = 0;
    for i=0:n-1
        x(i+2) = x(i+1) + h;
        x_h_2(i+1) = x(i+1) + (h/2);
        y_h_2(i+1) = y_mittelpunkt(i+1) + (h/2) * f(x(i+1),y_mittelpunkt(i+1));
        y_mittelpunkt(i+2) = y_mittelpunkt(i+1) + h * f(x_h_2(i+1),y_h_2(i+1));
    end

    % Modifiziertes Euler-Verfahren
    y_modeuler(1) = y0;
    y_Euler = 0; k1 = 0; k2 = 0;
    for i=0:n-1
        x(i+2) = x(i+1) + h;
        y_Euler(i+1) = y_modeuler(i+1) + h * f(x(i+1),y_modeuler(i+1));
        k1 = f(x(i+1),y_modeuler(i+1));
        k2 = f(x(i+2),y_Euler(i+1));
        y_modeuler(i+2) = y_modeuler(i+1) + h * (k1+k2)/2;
    end
      
    WIN05_IT13t_S5_Aufg1(f, a, b, a, b, h, h)
    hold on
    plot(x,y_euler, x,y_mittelpunkt, x,y_modeuler);
    xlabel('x'); ylabel('y(x)');
    legend('Richtungsfeld','Eulerverfahren','Mittelpunktverfahren',...
        'modifiziertes Eulerverfahren');
    grid on;
    hold off;
end