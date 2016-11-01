% Nullstellensuche mit Fixpunktiteration

format compact; format long; clear all; clc;

% Fixpunktgleichung
f = @(x) 3./(4.*asin(1./(2.*x)));
F = @(x) 1./(2.*sin(3./(4.*x)));
f1 = @(x) asin(1./(2.*x))
f2 = @(x) 3./(4.*x)

% Intervallgrenzen
a = -1;
b = 1;

% Startwert
x(1) = -0.5;

% Toleranz
tol = 1e-6;

% plot Funktion
figure;
xi = linspace(a,b);
plot(xi,f1(xi),xi,f2(xi));
xlabel('x');
ylabel('y');
ylim([-5 5])
grid on;
legend(func2str(f1),func2str(f2),'location','best');

% Nullstelle im Intervall [a,b]
abs_err = 2*tol;
n = 0;
while (abs_err > tol)
    n = n+1;
    x(n+1) = F(x(n));
    abs_err = abs(x(n+1) - x(n));
end

root = x(length(x))
n
abs_err
