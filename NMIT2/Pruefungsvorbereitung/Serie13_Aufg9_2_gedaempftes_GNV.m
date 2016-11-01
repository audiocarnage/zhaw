% NMIT2 - Serie 13, Aufgabe 9.2
% Ausgleichsrechnung, Quadratmittelproblem
% mit dem gedaempften Gauss-Newton-Verfahren

format compact; format long; clear all; clc;

%x = (1:4)';
x = (0:4)';
%y = [7.1 7.9 8.3 8.8]';
y = [3 1 0.5 0.2 0.05]';
N = length(x);
lambda0 = [1 1]';

syms a b
%g = y - a.*log(x+b);
g = y - a.*exp(b.*x);
Dg = jacobian(g,[a,b])

Dgvec = matlabFunction(Dg,'vars',[a,b]);
gvec = matlabFunction(g,'vars',[a,b]);

k = 1;
lambda(:,k) = lambda0;
tol = 1e-6;
norm = tol + 1;
err = tol + 1;
pmax = 8;

while (norm < tol)
    Dg_eval = Dgvec(lambda(1,k),lambda(2,k));
    g_eval = gvec(lambda(1,k),lambda(2,k));
    delta(:,k) = (Dg_eval' * Dg_eval) \ (-Dg_eval' * g_eval);
    
    lambdaTemp = 0;
    lambdaMin = inf;
    for p=0:pmax
        lambdaTemp = lambda(:,k) + (delta(:,k)/(2^p));
        g_evalTemp = gvec(lambdaTemp(1,1),lambdaTemp(2,1));
        
        if (norm(g_evalTemp,2)^2 < norm(g_eval,2)^2)
            break;
        end
        
    end
    
    lambda(:,k+1) = lambda(:,k) + delta(:,k);
    
    err = abs(norm(gvec(lambda(1,k+1),lambda(2,k+1)),2)^2 - ...
            norm(gvec(lambda(1,k),lambda(2,k)),2)^2);
    k = k+1;
end

k
lambda(:,k)
