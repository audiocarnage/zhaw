% @author Rémi Georgiou (georgrem)
% Implementation der Lagrange-Interpolation
% Beispiel:
% x = [exp(1)-0.5 exp(1)-0.25 exp(1)+0.25 exp(1)+0.5];
% y = [3.9203 5.9169 11.3611 14.8550];
% [yn] = LagrangeInterpolation(x,y,exp(1))

function[yn] = LagrangeInterpolation(x,y,xn)
    
    if (length(x) ~= length(y))
       error('Dimensions must agree.') 
    end
    
    n = length(x)-1;
    
    yn = 0;
    Lagrangepolynome = zeros(1,n);
    for i=0:n
       Lagrangepolynome(i+1) = LagrangePolynom(xn,i);
       yn = yn + (Lagrangepolynome(i+1) * y(i+1));
    end
    Lagrangepolynome

    function[prod] = LagrangePolynom(xl,i)
        prod = 1;
        for j=0:n
            if (i ~= j)
                prod = prod * ((xl-x(j+1))/(x(i+1)-x(j+1)));
            end
        end
    end

end