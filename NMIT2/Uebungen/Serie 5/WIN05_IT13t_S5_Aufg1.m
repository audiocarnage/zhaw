% NMIT2 - Serie 5, Aufgabe 1
% @author R�mi Georgiou (georgrem), Andr� Stocker (stockan1)
% Richtungfeld plotten
% Beispiel: WIN05_IT13t_S5_Aufg1(@(x,y) -(1/2).*y.*x.^2,-0.5,3.5,-0.5,3.5,0.5,0.5)

function[] = WIN05_IT13t_S5_Aufg1(f,xmin,xmax,ymin,ymax,hx,hy)

    [X,Y] = meshgrid(xmin:hx:xmax, ymin:hy:ymax);
    ydiff = f(X,Y);

    dum = ones(length(ydiff));
    quiver(X,Y,dum,ydiff,'r');
    xlabel('x');
    ylabel('y(x)');
    grid on;
    legend(sprintf('Richtungsfeld der DGL y''=f(x,y)=%s',func2str(f)),...
        'Location','NW');

end