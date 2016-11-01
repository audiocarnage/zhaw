% @author Rémi Georgiou (georgrem)
% Polynom Interpolation:
% Implementation des Aitken-Neville Schema
% Beispiel:
% x = [exp(1)-0.5 exp(1)-0.25 exp(1)+0.25 exp(1)+0.5];
% y = [3.9203 5.9169 11.3611 14.8550];
% [yn] = AitkenNeville(x,y,exp(1))

function[yn] = AitkenNeville(x,y,xn)
    
    if (length(x) ~= length(y))
       error('Dimensions must agree.')
    end
    
    n = length(x)-1;
    
    pnn = sym(zeros(n+1,length(x)));
    
    for i=1:n+1
        pnn(i,1) = y(i);
        for j=2:i
            pnn(i,j) = simplify((((x(i)-xn)*pnn(i-1,j-1)) + ((xn-x(i-j+1))*pnn(i,j-1))) / (x(i)-x(i-j+1)));
        end
    end
    
    pretty(pnn)
    yn = pnn(n+1,n+1);
end