% @author Rémi Georgiou
% Nullstelle numerisch berechnen
% Implentierung des Standard Newton-Verfahrens
% Beispiel: [root,xit,n] = NewtonVerfahren(@(x) cos(x)+exp(-2.*sin(x)),0,1e-12)

function[root,xit,n] = NewtonVerfahren(f,x0,tol)

    syms x
    df = matlabFunction(diff(f,x));

    if (df(x0) == 0)
        error('Ungeeigneter Startwert x0');
    end

    xit(1) = inf;
    xit(2) = x0;
    n = 0;
    nmax = 100;
    i = 1;
    while (abs(xit(i+1) - xit(i)) > tol && n < nmax)
        i = i+1;
        xit(i+1) = xit(i) - (f(xit(i)) / df(xit(i)));
    end
    n = i-1;
    root = xit(length(xit));
    
    % plot the function and root
    x = linspace(root-1,root+1);
    figure;
    plot(x,f(x));
    hold on;
    plot(root,f(root),'r-o','MarkerSize',6);
    hold off;
    xlabel('x');
    ylabel('f(x)');
    grid on;
    legend(func2str(f),'berechnete Nullstelle','location','best');
    
end