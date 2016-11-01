% Funktion Georgiou_Remi_IT13t_S9_Aufg2
% Parameter:
% Matrix A und Vektor b des linearen Gleichungssystem Ax=b
% gestörte Matrix Ahat und Vektor bhat des gestörten Gleichungssystems 
% Ahat * x = bhat
% Rückgabewerte:
% x: Lösung des linearen Gleichungssystems Ax=b
% xhat: Lösung des gestörten Gleichungssystems Ahat * x = bhat
% dxmax: Obere Schranke des relativen Fehlers
% dxobs: tatsächlich beobachteter relativer Fehler

function[x,xhat,dxmax,dxobs] = Georgiou_Remi_IT13t_S9_Aufg2(A,Ahat,b,bhat)

% LGS lösen
x = A\b;
xhat = Ahat\bhat;

% Zwischenresulate
n = norm(A-Ahat,inf)/norm(A,inf);
p = norm(b-bhat,inf)/norm(b,inf);
c = cond(A,inf) * n;

% Überprüfung der Vorbedingung bevor die Abschätzung der fehlerbehafteten
% Matrix berechnet wird
if c >= 1
   dxmax = 'NaN';
else
    % Obere Schranke des relativen Fehlers
    dxmax = cond(A,inf)/(1-c) * (n+p);
end

% Beobachteter relativer Fehler
dxobs = norm(x-xhat,inf)/norm(x,inf);

end