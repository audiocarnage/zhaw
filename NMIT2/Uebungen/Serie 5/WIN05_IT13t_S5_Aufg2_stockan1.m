% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 5, Aufgabe 2 
% Eulerverfahren

clc; format short; clear all; format compact;

syms y x;
a = 0; b = 2.1; n = 3;
h = (b-a)/n;
f = @(x,y) (x.^2)./y;
f_exakt = @(x) sqrt(((2*x^3)/3) + 4);
x0 = 0; y0 = 2;
xi(1) = x0; yi(1) = y0;

disp('Euler-Verfahren');
abs_err(1) = abs(f_exakt(xi(1)) - yi(1));
fprintf('i = %d, x_i = %.4f, y_i = %.4f abs_err = %.4f \n', 0,xi(1),yi(1),abs_err(1));
for i=0:n-1
    xi(i+2) = xi(i+1) + h;
    yi(i+2) = yi(i+1) + h * f(xi(i+1),yi(i+1));
    abs_err(i+2) = abs(f_exakt(xi(i+2)) - yi(i+2));
    fprintf('i = %d, x_i = %.4f, y_i = %.4f abs_err = %.4f \n', i+1,xi(i+2),yi(i+2),abs_err(i+2));
end
disp('--------------------------------------------------');

disp('Mittelpunkt-Verfahren');
abs_err(1) = abs(f_exakt(xi(1)) - yi(1));
fprintf('i = %d, x_i = %.4f, y_i = %.4f abs_err = %.4f \n', 0,xi(1),yi(1),abs_err(1));
y_h_2 = 0;
for i=0:n-1
    xi(i+2) = xi(i+1) + h;
    x_h_2(i+1) = xi(i+1) + (h/2);
    y_h_2(i+1) = yi(i+1) + (h/2) * f(xi(i+1),yi(i+1));
    yi(i+2) = yi(i+1) + h * f(x_h_2(i+1),y_h_2(i+1));
    abs_err(i+2) = abs(f_exakt(xi(i+2)) - yi(i+2));
    fprintf('i = %d, x_i = %.4f, y_i = %.4f abs_err = %.4f \n', i+1,xi(i+2),yi(i+2),abs_err(i+2));
end
disp('--------------------------------------------------');

disp('Modifiziertes Euler-Verfahren');
y_euler = 0; k1 = 0; k2 = 0;
abs_err(1) = abs(f_exakt(xi(1)) - yi(1));
fprintf('i = %d, x_i = %.4f, y_i = %.4f abs_err = %.4f \n', 0,xi(1),yi(1),abs_err(1));
for i=0:n-1
    xi(i+2) = xi(i+1) + h;
    y_euler(i+1) = yi(i+1) + h * f(xi(i+1),yi(i+1));
    k1 =  f(xi(i+1),yi(i+1));
    k2 =  f(xi(i+2),y_euler(i+1));
    yi(i+2) = yi(i+1) + h * (k1+k2)/2;
    abs_err(i+2) = abs(f_exakt(xi(i+2)) - yi(i+2));
    fprintf('i = %d, x_i = %.4f, y_i = %.4f abs_err = %.4f \n', i+1,xi(i+2),yi(i+2),abs_err(i+2));
end
