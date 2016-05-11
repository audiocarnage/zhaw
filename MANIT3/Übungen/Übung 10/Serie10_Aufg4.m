% Serie 10, Aufgabe 4

format compact; format short; clear all; clc;

p = 0.03;
n = 120;
x = 0:120;

% a) Niemand zeigt Nebenwirkungen
fprintf('P(X=0) = %1.5f\n', binopdf(0,n,p))

% b) 99% WSK mindestens 2 Personen mit Nebenwirkungen
syms nx
eqn = (1 - ((1-p)^(nx)) - (nx*p*((1-p)^(nx-1)))) == 0.99;
s = solve(eqn, nx);
s = ceil(vpa(s))

% Lösen durch Probieren
px = 0.99;
for i=n:1000
    if (1 - ((1-p)^(i)) - (i*p*((1-p)^(i-1))) >= px)
        fprintf('\ni = %d\n',i)
        1 - ((1-p)^(i)) - (i*p*((1-p)^(i-1)))
        break;
    end
end
