% @author Rémi Georgiou (georgrem)
% Polynom Interpolation:
% Implementation der Lagrange-Interpolation
% Beispiel:
% x = [exp(1)-0.5 exp(1)-0.25 exp(1)+0.25 exp(1)+0.5];
% y = [3.9203 5.9169 11.3611 14.8550];
% [yn] = LagrangeInterpolation(x,y,exp(1))

function[yn,p] = LagrangeInterpolation(xi,yi,xn)
    
    if (length(xi) ~= length(yi))
       error('Dimensions must agree.') 
    end
    
    n = length(xi)-1;
    
    yn = 0;
    Lagrangepolynome = sym(zeros(1,n));
    for i=0:n
       Lagrangepolynome(i+1) = LagrangePolynom(xn,i);
       yn = yn + (Lagrangepolynome(i+1) * yi(i+1));
    end
    p = Lagrangepolynome

    function[prod] = LagrangePolynom(xl,i)
        prod = 1;
        for j=0:n
            if (i ~= j)
                prod = prod * ((xl-xi(j+1))/(xi(i+1)-xi(j+1)));
            end
        end
    end

end