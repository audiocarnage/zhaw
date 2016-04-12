% @author Rémi Georgiou (georgrem)
% Vierstufiges Runge-Kutta Verfahren
% Beispiel: [x,y] = RungeKutta4(@(x,y) x^2 + 0.1*y,-1.5,1.5,5,0)

function[x,y] = RungeKutta4(f,a,b,n,y0)

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
end