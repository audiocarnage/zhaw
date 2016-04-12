% Script-Aufgabe 7.4
% Anfangswertproblem gelöst mit dem vierstufigen Runge-Kutta Verfahren
% Beispiel: [x,y] = Aufgabe7_4(@(x,y) y,0,1,10,1)

function[x,y] = Aufgabe7_4(f,a,b,n,y0)

    format compact; format shortE; clc;

    h = (b-a)/n;

    x(1) = a;
    y(1) = y0;

    for i=1:n
       k1(i) = f(x(i),y(i));
       k2(i) = f(x(i) + (h/2),y(i) + (h*k1(i)/2));
       k3(i) = f(x(i) + (h/2),y(i)+ (h*k2(i)/2));
       k4(i) = f(x(i) + h,y(i) + (h*k3(i)));
       x(i+1) = x(i) + h;
       y(i+1) = y(i) + (h*(k1(i)+(2*k2(i))+(2*k3(i))+k4(i))/6);
    end
    y
    
    [X,Y] = meshgrid(a:h:b, y0:h:y(n));
    ydiff = f(X,Y);
    
    figure;
    plot(x,y,'b-','LineWidth',2);
    title('Vierstufiges Runge-Kutta Verfahren');
    hold on;
    quiver(X,Y,ones(size(X)),ydiff,'r');
    xlabel('x');
    ylabel('y(x)');
    legend(sprintf('y''=f(x,y)=%s',func2str(f)),...
        sprintf('Richtungsfeld der DGL y''=f(x,y)=%s',func2str(f)),...
        'Location','NW');
    grid on;
    hold off;
    
end