% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 5, Aufgabe 1 
% Richtungsfelder plotten
% Beispiel: WIN05_IT13t_S5_Aufg1(@(x,y) -(1/2).*y.*x.^2,-0.5,3.5,-0.5,3.5,0.5,0.5)

function[] = WIN05_IT13t_S5_Aufg1(f, xmin, xmax, ymin, ymax, hx, hy)
    clc; format short; format compact;

    [X,Y] = meshgrid(xmin:hx:xmax, ymin:hy:ymax);
    Ydiff = f(X,Y);
    dum = ones(length(Ydiff));
    quiver(X,Y,dum,Ydiff);
    xlabel('x');
    ylabel('y(x)');
    grid on;
    legend(sprintf('Richtungsfeld der DGL y''=f(x,y)=%s',func2str(f))',...
         'Location','NW');
end