% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Romberg-Extrapolation Algorithmus
% Beispiel: [T] = Romberg(@(x) exp(-x.^2),0,0.5,3)

function[T] = Romberg(f,a,b,n)

    if (a >= b)
       error('Ungültiges Intervall')
    end

    syms x
    F = matlabFunction(int(f,x));
    F_eval = F(b);

    t = zeros(n+1);
    err = zeros(n+1);

    % Ti0
    for i=0:n
        % Summierte Trapezformel
        h = (b-a)/2^i;
        Tf = 0;
        for j=1:2^(i)-1
            Tf = Tf + f(a + j*h);
        end
        Tf = h * (((f(a) + f(b))/2) + Tf);
        t(i+1,1) = Tf;
        err(i+1,1) = abs(t(i+1,1) - F_eval);
    end

    % Tik
    for k=1:n
        for i=0:n-k
            t(i+1,k+1) = ((4^(k)*t(i+2,k))-(t(i+1,k)))/(4^(k)-1);
            err(i+1,k+1) = abs(t(i+1,k+1) - F_eval);
        end
    end
    
    t
    T = t(1,length(t));
end