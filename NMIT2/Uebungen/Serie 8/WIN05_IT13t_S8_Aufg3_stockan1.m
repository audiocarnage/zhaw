% NMIT2 - Serie 8, Aufgabe 3
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Adaptive Schrittweite

clc; format shortE; clear all; format compact;
f = @(x,y) -12.*y+30.*exp(-2.*x);
F = @(x) 3.*(1-exp(-10.*x)).*exp(-2.*x);
a = 0; b = 10; y0 = 0; h = 0.1;
n = (b-a)/h;
TOL = 10^(-4);

[x, y_euler, y_mittelpunkt, ~] = WIN05_IT13t_S5_Aufg3(f, a, b, n, y0);

n = 1;
a_current = a;
b_current = a_current + h;
yM_current = y0;
x_adaptiv(1) = x(1); yM_adaptiv(1) = y_mittelpunkt(1);
hV(1) = h;
while b_current < b
   [x_i, yE, yM, ~] = WIN05_IT13t_S5_Aufg3(f, a_current, b_current, n, yM_current);
   if abs(yM(2)-yE(2)) < (TOL/20)
       a_current = a_current + h;
       h = 2*h;
   elseif abs(yM(2)-yE(2)) >= TOL
       h = h/2;
   else
       a_current = a_current + h;
   end
   b_current = a_current + h;
   yM_current = yM(2);
   x_adaptiv = [x_adaptiv, x_i(2)];
   yM_adaptiv = [yM_adaptiv, yM(2)];
   hV = [hV, h];
end

subplot(1,2,1);
plot(x,F(x),'bo', x,y_euler, x,y_mittelpunkt, x_adaptiv,yM_adaptiv,'--');
xlabel('x'); ylabel('y(x)');
legend('Exakte Lösung','Eulerverfahren','Mittelpunktverfahren',...
    'Mittelpunktverfahren mit adaptiver Schrittweite');

subplot(1,2,2);
plot(x_adaptiv,hV);
xlabel('x'); ylabel('h');
grid on;

