% @author R�mi Georgiou (georgrem), Andr� Stocker (stockan1)
% Vierstufiges Runge-Kutta Verfahren zum l�sen von DGL 1. Ordnung
% Beispiel: [x,y] = RungeKutta4(@(x,y) x^2 + 0.1*y,-1.5,1.5,5,0)

function[x_RK4,y_RK4] = RungeKutta4_sym(f,a,b,n,y0)

    h = (b-a)/n;
    x_RK4(1) = sym(a);
    y_RK4(1) = sym(y0);

    for i=1:n
       k1(i) = f(x_RK4(i),y_RK4(i));
       k2(i) = f(x_RK4(i) + (h/2),y_RK4(i) + (h*k1(i)/2));
       k3(i) = f(x_RK4(i) + (h/2),y_RK4(i)+ (h*k2(i)/2));
       k4(i) = f(x_RK4(i) + h,y_RK4(i) + (h*k3(i)));
       x_RK4(i+1) = x_RK4(i) + h;
       y_RK4(i+1) = y_RK4(i) + (h/6.0*(k1(i) + (2*k2(i)) + (2*k3(i)) + k4(i)));
    end
end