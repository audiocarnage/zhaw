% @author Rémi Georgiou (georgrem)
% Implementation der Lagrange-Interpolation

function[yn] = LagrangeInterpolation(x,y,xn)

    format compact; format short; clc;
    
    if (length(x) ~= length(y))
       error('Dimensions must agree.') 
    end
    
    n = length(x)-1;
    
    yn = 0;
    li = zeros(1,n);
    for i=0:n
       li(i+1) = LagrangePolynom(xn,i);
       yn = yn + (li(i+1) * y(i+1));
    end

    function[prod] = LagrangePolynom(xl,i)
        prod = 1;
        for j=0:n
            if (i ~= j)
                prod = prod * ((xl-x(j+1))/(x(i+1)-x(j+1)));
            end
        end
    end

end