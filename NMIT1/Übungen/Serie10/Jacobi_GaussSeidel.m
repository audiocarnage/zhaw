function [xn,n,n2] = jacobi_iteration(l,d,r,b,x0,tol)
        B = -(inv(d)) * (l+r);
        xdiff = 1;
        xnorm = 1;
        n = 0;
        k = length(d);
        x(1:k) = 0.0;
        while (sqrt(xdiff/xnorm) > tol)
           xneu(1) = (b(1) - r(1) * x(2))/d(1);
           for i=2:k-1
               xneu(i) = (b(i) - l(i) * x(i-1) - r(i)*x(i+1))/d(i);
           end
           xneu(k) = (b(k) - l(k) * x(k-1))/d(k);
           xdiff = 0;
           xnorm = 0;
           for i=1:k
              xdiff = xdiff + (xneu(i)-x(i))^2;
              x(i) = xneu(i);
              xnorm = xnorm + x(i)^2;
           end
           if (xnorm == 0)
              xnorm = 1; 
           end
           n = n + 1;
        end
        xn = x(n);
        syms m;
        m = m;
        eqn = norm(x(n)-(B^(-1)*(-b)),inf) == norm(B,inf)^(m)/(1-norm(B,inf))*norm(x(1)-x0,inf);
        n2 = floor(solve(eqn,m));
    end

    function [xn,n,n2] = gaussseidel_iteration(l,d,r,b,x0,tol)
        B = -inv(d+l) * r;
        xdiff = 1;
        xnorm = 1;
        n = 0;
        k = length(d);
        x(1:n) = x0;
        while (sqrt(xdiff/xnorm) > tol)
            xalt = x;
            x(1) = (b(1) - r(1) * x(2))/d(1);
            for i=2:k-1
                x(i) = (b(i) - l(i) * x(i-1) - r(i) * x(i+1))/d(i);
            end
            x(k) = (b(k) - l(k) * x(k-1))/d(k);
            xdiff = 0;
            xnorm = 0;
            for i=1:k
                xdiff = xdiff + (x(i)-xalt(i))^2;
                xnorm = xnorm + xalt(i)^2;
            end
            if (xnorm == 0)
               xnorm = 1; 
            end
            n = n + 1;
        end
        xn = x(n);
        syms m;
        m = m;
        eqn = norm(x(n)-(B^(-1)*(-b)),inf) == norm(B,inf)^(m)/(1-norm(B,inf))*norm(x(1)-x0,inf);
        n2 = floor(solve(eqn,m));
    end