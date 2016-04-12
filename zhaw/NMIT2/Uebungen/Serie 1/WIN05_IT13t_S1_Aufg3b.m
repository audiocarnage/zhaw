% NMIT2 - Serie 1, Aufgabe 3 b)
% @author Georgiou Rémi, Stocker André
% zeitabhaengige gedaempfte Schwingung eines Fedependels

format compact; format short; clear all; clc;

% Parameter
n = 1000;

syms t;
xi = @(t) 10*exp(-0.05*t)*cos(0.2*pi*t);
dx = matlabFunction(diff(xi,t));
ddx = matlabFunction(diff(dx,t));

x = zeros(n,1);
tv = zeros(n,1);
dxv = zeros(n,1);
ddxv = zeros(n,1);

for i=1:n
    ti = 0+i*0.1;
    tv(i) = ti;
    x(i) = xi(ti);
    dx_eval = (feval(dx, ti));
    dxv(i) = dx_eval;
    ddx_eval = (feval(ddx, ti));
    ddxv(i) = ddx_eval;
end

figure('name','NMIT2 - Serie 1, Aufgabe 3 b)');
plot(tv,x,'b--',tv,dxv,'g:',tv,ddxv,'r-','LineWidth',2);
title('zeitabhaengige gedaempfte Schwingung eines Fedependels');
xlabel('t [s]');
ylabel('y');
grid on;
legend('Auslenkung x(t)','Geschwindigkeit v(t)','Beschleunigung a(t)',...
    'Location','NE');
