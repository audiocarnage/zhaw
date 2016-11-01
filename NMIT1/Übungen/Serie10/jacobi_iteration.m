% Funktion jacobi_iteration.m
% input:    Diagonalen l,d,u der koeffizientenmatrix a, rechte Seite b
% output:   Loesung x
% Aufruf: [x] = jacobi_iteration(l,d.u,b)
function [x] = jacobi_iteration(l,d,u,b)

xdiff = 1;
xnorm = 1;
it = 0;
n = length(d);
x(l:n) = 0.0;
while (sqrt(xdiff/xnorm) > 10^(-10))
   xneu(1) = (b(l) - u(1) * x(2))/d(1);
   for i=2:n-1
       xneu(i) = b(i) - l(i) * x(i-1) - u(i) * x (i+1)/d(i);
   end
   xneu(n) = (b(n) - l(n) * x(n-1))/d(n);
   xdiff = 0;
   xnorm = 0;
   for i=1:n
      xdiff = xdiff + (xneu(i)-x(i))^2;
      x(i) = xneu(i);
      xnorm = xnorm + x(i)^2;
   end
   if (xnorm == 0)
      xnorm = 1; 
   end
   it = it +1;
end
it
end