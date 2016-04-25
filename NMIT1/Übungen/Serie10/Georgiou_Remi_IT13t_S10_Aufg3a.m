% Funktion Georgiou_Remi_IT13t_S10_Aufg3a
% input:    Matrix A, Vektor b, Toleranzwert tol, Startvektor x0
% input option Jacobi-Verfahren: 'jacobi'
% input option Gauss-Seidel-Verfahren: 'gs'
% output:   Iterationsvekor xn nach n Iterationen und die Anzahl benötigter
% Schritte n2 gemäs à-priori Abschätzung.
% Aufruf: [xn,n,n2] = Georgiou_Remi_IT13t_S10_Aufg3a(A,b,x0,tol,opt)

function[xn,n,n2] = Georgiou_Remi_IT13t_S10_Aufg3a(A,b,x0,tol,opt)

L = tril(A,-1);
R = triu(A,1);
D = diag(diag(A,0));

if (strcmp(opt,'jacobi') == 1)
    [xn,n,n2] = jacobi_iteration(L,D,R,b,x0,tol);
elseif (strcmp(opt,'gs') == 1)
    % Gauss-Seidel-Verfahren
    [xn,n,n2] = gaussseidel_iteration(L,D,R,b,x0,tol);
end

    function [x,it,apriori] = jacobi_iteration(l,d,r,b,x0,tol)
        B = -(inv(d)) * (l+r);
        it = 0;
        xalt = zeros(size(x0))
        x = x0;
        dinv = inv(d);
        x1 = x0;
        while (norm(x-xalt,inf) > tol)
            it = it + 1;
            xalt = x;
            x = (-dinv * (l+r) * xalt) + (dinv * b);
            if (it == 1)
                x1 = x;
            end
        end
        syms m;
        m = m;
        eqn = tol == norm(B,inf)^(m)/(1-norm(B,inf))*norm(x1-x0,inf);
        apriori = floor(solve(eqn,m));
    end

    function [x,it,apriori] = gaussseidel_iteration(l,d,r,b,x0,tol)
        B = -(inv(d)) * (l+r);
        it = 0;
        xalt = zeros(size(x0));
        x = x0;
        dlinv = inv(d+l);
        x1 = x0;
        while (norm(x-xalt,inf) > tol)
            it = it + 1;
            xalt = x;
            x = -dlinv*r*xalt + dlinv*b;
            if (it == 1)
                x1 = x;
            end
        end
        syms m;
        m = m;
        eqn = tol == norm(B,inf)^(m)/(1-norm(B,inf))*norm(x1-x0,inf);
        apriori = floor(solve(eqn,m));
    end

clear L;
clear R;
clear D;
end