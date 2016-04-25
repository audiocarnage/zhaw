% @author Georgiou Rémi (georgrem), Stocker André (stockan1)

clc;
format long;

a = 5; b = 20; n = 5;
fx = @(x) 10*x.^(-3/2);
Fx = integral(fx,a,b);
h = (b-a) / n;
Rf = 0; Tf = 0;

for i = 0 : n-1
    x = a + i*h + h/2;
    Rf = Rf + fx(x);
end
Rf = h * Rf
E_Rf = abs(Fx - Rf)

for i = 1 : n-1
    x = a + i*h;
    Tf = Tf + fx(x);
end
Tf = h * ((fx(a)+fx(b))/2 + Tf)
E_Tf = abs(Fx - Tf)