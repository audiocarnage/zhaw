% Funktion NewtonVerfahren(func,a,b,tol)
% Implentierung des Standard Newton-Verfahrens
% Beispiel: [root,xit,n] = NewtonVerfahren(@(x) log(x^2),1,1e-6)

function [root,xit,n] = NewtonVerfahren(func,t,x0)

% Ableitung berechen mit h^2-Extrapolation

epsilon = 1e-5;


df = diff(f);


if df(sym(x0)) == 0
    error('Ungeeigneter Startwert x0');
end

xit = [inf x0];
x = x0;
n = 0;
i = 1;
while (f() < 0)
    xn = double(x - (f(x) / df(x)));
    xit = [xit xn];
    x = xn;
    n = n+1;
end
root = xit(length(xit));
end