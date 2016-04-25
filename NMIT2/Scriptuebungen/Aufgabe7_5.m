% Script-Aufgabe 7.5
% Mehrstufiges DGL-Lösungsverfahren, Adams-Bashforth
% Beispiel: [x,y] = Aufgabe7_5(@(x,y) y,0,1,10,1)

function[] = Aufgabe7_5(f,a,b,n,y0)

    format compact; format shortE; clc;

    h = (b-a)/n;
    
    % Berechnung mit Runge-Kutta 4 Verfahren
    [x_RK4,y_RK4] = RungeKutta4(f,a,b,n,y0);
    
    % Adams-Bashforth Methode 2. Ordnung
    x_AB2 = x_RK4(1:2);
    y_AB2 = y_RK4(1:2);
    for i=2:n
        x_AB2(i+1) = x_AB2(i) + h;
        y_AB2(i+1) = y_AB2(i) + h/2*(3*f(x_AB2(i),y_AB2(i)) - f(x_AB2(i-1),y_AB2(i-1)));
    end
    
    % Adams-Bashforth Methode 3. Ordnung
    x_AB3 = x_RK4(1:3);
    y_AB3 = y_RK4(1:3);
    for i=3:n
        x_AB3(i+1) = x_AB3(i) + h;
        y_AB3(i+1) = y_AB3(i) + h/12*(23*f(x_AB2(i),y_AB2(i)) ...
                - 16*f(x_AB2(i-1),y_AB2(i-1)) ...
                + 5*f(x_AB3(i-2),y_AB3(i-2)));
    end
    
    fprintf(1, 'i \t xi \t yi AB2 \t\t yi AB3 \t\t yi RK4 \n')
    for i=1:n+1
        fprintf('%.f \t %.2f \t %e \t %e \t %e \n', i-1, x_RK4(i),y_AB2(i),y_AB3(i), y_RK4(i));
    end
    
    figure;
    plot(x_AB2,y_AB2,'k',x_AB3,y_AB3,'r',x_RK4,y_RK4,'b','LineWidth',1.5);
    title(sprintf('Einstufiges vs. Mehrstufiges DGL-Lösungsverfahren für y''=f(x,y)=%s', func2str(f)));
    xlabel('x');
    ylabel('y(x)');
    legend('Adams-Bashforth 2. Ordnung','Adams-Bashforth 3. Ordnung','Runge-Kutta 4','Location','NW');
    grid on;
    hold off;
    
end