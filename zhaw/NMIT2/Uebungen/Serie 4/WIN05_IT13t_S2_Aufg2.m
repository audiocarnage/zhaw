% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Algorithmus für die h^2-Extrapolation
% Beispiel: [D] = WIN05_IT13t_S2_Aufg2(@(x) log(x^2),2,0.1,3)

function[D] = WIN05_IT13t_S2_Aufg2(f,x0,h0,n)

syms x
fdiff = matlabFunction(diff(f,x));

fdiff_eval = fdiff(x0)
DF = @(x0,h) (f(x0+h)-f(x0-h))/(2*h);
d = zeros(n+1);
error = zeros(n+1);

for i=0:n
    d(i+1,1) = DF(x0,h0/2^i);
    error(i+1,1) = abs(d(i+1,1) - fdiff_eval);
end

for k=1:n
    for i=0:n-k
        d(i+1,k+1) = ((4^(k)*d(i+2,k))-(d(i+1,k)))/(4^(k)-1);
        error(i+1,k+1) = abs(d(i+1,k+1) - fdiff_eval);
    end
end
D = d(1,n+1);
end