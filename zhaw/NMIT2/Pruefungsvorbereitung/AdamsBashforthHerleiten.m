% Adams-Bashforth Methode n-ter Ordnung herleiten

format compact; format rat; clear all; clc;

% Berechnung der Gewichte
s = 4;
j = 0:s;
n = s+1;

factor = (-1).^(j) ./ (factorial(j) .* factorial(s-j));

syms x;
f(1) = (x+1)*(x+2)*(x+3)*(x+4);
f(2) = (x+0)*(x+2)*(x+3)*(x+4);
f(3) = (x+0)*(x+1)*(x+3)*(x+4);
f(4) = (x+0)*(x+1)*(x+2)*(x+4);
f(5) = (x+0)*(x+1)*(x+2)*(x+3);

for i=0:s
    T = Romberg(matlabFunction(f(i+1)),0,1,n)
    b(i+1) = factor(i+1) * T;
end

disp('Koeffizienten:');
disp(b)