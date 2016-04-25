% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Vierstufiges Runge-Kutta Verfahren zum lösen von DGL 1. Ordnung
% Beispiel: [x,y] = RungeKutta4(@(x,y) x^2 + 0.1*y,-1.5,1.5,5,0)

function[x_RK4,y_RK4] = RungeKutta4(f,a,b,n,y0)

    h = (b-a)/n;
    x_RK4(1) = a;
    y_RK4(1) = y0;

    for i=1:n
       k1(i) = f(x_RK4(i),y_RK4(i));
       k2(i) = f(x_RK4(i) + (h/2),y_RK4(i) + (h*k1(i)/2));
       k3(i) = f(x_RK4(i) + (h/2),y_RK4(i)+ (h*k2(i)/2));
       k4(i) = f(x_RK4(i) + h,y_RK4(i) + (h*k3(i)));
       x_RK4(i+1) = x_RK4(i) + h;
       y_RK4(i+1) = y_RK4(i) + (h/6.0*(k1(i) + (2*k2(i)) + (2*k3(i)) + k4(i)));
    end
     
    %disp('Runge Kutta 4')
    %fprintf('xi \t\t\t\t\t yi \t\t\t\t k1 \t\t\t\t k2 \t\t\t\t k3 \t\t\t\t k4 \n')
    %disp([x_RK4(1:n)' y_RK4(1:n)' k1' k2' k3' k4'])
    %disp([x_RK4(n+1) y_RK4(n+1)])
end