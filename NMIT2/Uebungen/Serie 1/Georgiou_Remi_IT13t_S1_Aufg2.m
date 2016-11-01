clc
format compact
format shortE

x0 = 2;
f = @(x) log(x^2);
fprime = @(x) 2/x;

d1f = @(x0,h) (f(x0 + h) - f(x0)) / h;
d2f = @(x0,h) (f(x0 + h) - f(x0 - h)) / 2*h;

fprintf(1, 'h \t\t D1 \t\t\t D2 \t\t\t\t abs error D1f \t\t abs error D2f \n')
for i=1:17
    h = 10^(-i);
    d1 = d1f(x0,h);
    d2 = d2f(x0,h);
    fprintf(1, '%1.1e\t %1.8f \t %1.13f \t %e \t\t %e \n', ...
        h, d1, d2, abs(d1-fprime(x0)), abs(d2-fprime(x0)))
end

f3diff = @(x) 6*x^(-4);
f2diff = @(x) -2*x^(-3);

hoptD1f = (4*eps*(abs(f(x0)))/abs(f2diff(x0)))^(1/2)
hoptD2f = (6*eps*(abs(f(x0))/abs(f3diff(x0))))^(1/3)