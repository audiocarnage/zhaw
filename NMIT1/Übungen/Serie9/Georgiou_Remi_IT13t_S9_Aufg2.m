% Funktion Georgiou_Remi_IT13t_S9_Aufg2
% Parameter:
% Matrix A und Vektor b des linearen Gleichungssystem Ax=b
% gest�rte Matrix Ahat und Vektor bhat des gest�rten Gleichungssystems 
% Ahat * x = bhat
% R�ckgabewerte:
% x: L�sung des linearen Gleichungssystems Ax=b
% xhat: L�sung des gest�rten Gleichungssystems Ahat * x = bhat
% dxmax: Obere Schranke des relativen Fehlers
% dxobs: tats�chlich beobachteter relativer Fehler

function[x,xhat,dxmax,dxobs] = Georgiou_Remi_IT13t_S9_Aufg2(A,Ahat,b,bhat)

% LGS l�sen
x = A\b;
xhat = Ahat\bhat;

% Zwischenresulate
n = norm(A-Ahat,inf)/norm(A,inf);
p = norm(b-bhat,inf)/norm(b,inf);
c = cond(A,inf) * n;

% �berpr�fung der Vorbedingung bevor die Absch�tzung der fehlerbehafteten
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