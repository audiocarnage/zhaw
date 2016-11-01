% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 10, Aufgabe 2
% Natürliche kubische Splinefunktion
% Beispiel: yy = WIN05_IT13t_S10_Aufg2_stockan1([0 1 2 3], [2 1 2 2],  1:0.1:2)

function [yy,a,b,c,d]= WIN05_IT13t_S10_Aufg2_stockan1(xi, y, xx)
    clc; format shortE; format compact;

    n = length(xi);
    nxx = length(xx);

    a = y(1:n-1);
    h = xi(2:n) - xi(1:(n-1));
    c(1) = 0; c(n) = 0;

    ad = 2*(h(1:(n-2)) + h(2:(n-1))); ar = h(2:(n-2));
    D = diag(ad); D1 = diag(ar,1); D2 = diag(ar,-1);
    A = D + D1 + D2;
    dz = (y(2:n) - y(1:(n-1)))./h;
    z = 3*dz(2:n-1) - 3*dz(1:n-2);
    c(2:n-1) = (A\z')';

    b = ((y(2:n) - y(1:(n-1))) ./ h) - (h/3) .* (c(2:n) + 2*c(1:(n-1)));
    d = (1 / 3.*h) .* (c(2:n) - c(1:(n-1)));

    syms x
    S = @(i,x) a(i) + b(i).*(x-xi(i)) + (c(i).*(x-xi(i)).^2) + (d(i).*(x-xi(i)).^3);
    
    hold on; 
    for i = 1:(n-1)
        Si(i) = S(i,x); 
        for j = 1:(nxx)
            if xx(j) >= xi(i)& xx(j) <= xi(i+1)
                Sif = matlabFunction(Si(i));
                yy(j) = Sif(xx(j));
            end
        end
        xV = linspace(xi(i),xi(i+1),1000);
        SiV = S(i,xV);
        plot(xV,SiV,'linewidth',1.5)
    end
    plot(xi,y,'*',xx,yy,'o'); 
    xlabel('$x$','fontsize',18,'interpreter','latex'); ylabel('$f(x)$','fontsize',18,'interpreter','latex')
    title('Natural cubic spline for $f(x)$','fontsize',18,'interpreter','latex')
end