% Richtungsfeld plotten

function[] = Richtungsfeld(f,x,y)
    
    [X,Y] = meshgrid(x,y);
    Ydiff = f(X,Y);
    
    quiver(X,Y,ones(size(Ydiff)),Ydiff);
    xlabel('x');
    ylabel('y(x)');
    grid on;
end