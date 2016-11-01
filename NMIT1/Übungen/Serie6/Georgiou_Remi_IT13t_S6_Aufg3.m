% Funktion Georgiou_Remi_IT13t_S6_Aufg3(f,x0,x1,tol)
% Berechnung einer Nullstelle mittels Sekantenverfahren (regula falsi)
% Beim Implementieren des Newton-Verfahrens müsste in jedem
% Iterationschritt die Ableitung der Funktion symbolisch bestimmt werden
% mit diff(), http://ch.mathworks.com/help/symbolic/diff.html
% Parameter:
% f:    Funktion
% x0:   Startwert 1
% x1:   Startwert 2
% tol:  Toleranz
% Der Rückgabewert y liefert die genäherte Nullstelle.
% Beispiel eines Funktionsaufrufes:
% [y] = Georgiou_Remi_IT13t_S6_Aufg3(@(x) 1/15*x.^(3)-x.^(2)+29.9848,6,10,1e-3)

function[y] = Georgiou_Remi_IT13t_S6_Aufg3(f,x0,x1,tol)

if x0 == x1
    error('Ungültige Startwerte.');
end

% Startwerte
k(1) = (x1-x0) * f(x1) / (f(x1)-f(x0));
k(2) = x1 - ((x1-x0) * f(x1) / (f(x1)-f(x0)));
% Iteration
for i=2:100
    k(i+1) = k(i)-(((k(i)-k(i-1)) * f(k(i))) / (f(k(i))-f(k(i-1))));
     if abs(k(i+1) - k(i)) < tol
        break;
    end
end
y = k(length(k));
end