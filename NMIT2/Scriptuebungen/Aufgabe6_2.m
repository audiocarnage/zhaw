
clc
format compact
format shortE

h=10^(-2);
x0 = 1;
f = @(x) sin(x);
fdiff = @(x) cos(x);

d2f = @(x,h) (f(x0 + h) - f(x0 - h)) / 2*h;

i = 2;
while (i < 17)
    i
    abs_err = abs(d1f(x0,10^(-i)) - fdiff(x0))
    i = i + 2;
end
