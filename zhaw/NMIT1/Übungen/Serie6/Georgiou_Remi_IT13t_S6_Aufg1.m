% Script Georgiou_Remi_IT13t_S6_Aufg1

format compact; format shortE; clear all; clc;

syms x;
f = @(x) exp(x.^2) + x.^(-3) - 10;

% Newton-Verfahren
% Startwert
x0 = 2;
df = matlabFunction(diff(f(x)));
newton(1) = x0 - (f(x0) / df(x0));
f = df;
for i=1:4
    df = matlabFunction(diff(f(x)));
    newton(i+1) = newton(i) - (f(newton(i)) / df(newton(i)));
end
disp('Newton-Verfahren')
newton(length(newton))


% vereinfachtes Newton-Verfahren
% Startwert
x0 = 0.5;
fdiff = @(x) 2*x * exp(x.^2) - (3/x.^4);
newtonsimple(1) = x0 - (f(x0) / fdiff(x0));
for i=1:4
   newtonsimple(i+1) = newtonsimple(i) - (f(newtonsimple(i)) / fdiff(x0));
end
disp('Vereinfachtes Newton-Verfahren')
newtonsimple(length(newtonsimple))


% Sekantenverfahren
% Startwerte
x0 = -1.0;
x1 = -1.2;
sek(1) = (x1-x0) * f(x1) / (f(x1)-f(x0));
sek(2) = x1 - ((x1-x0) * f(x1) / (f(x1)-f(x0)));
for i=2:5
    sek(i+1) = sek(i)-(((sek(i)-sek(i-1)) * f(sek(i))) / (f(sek(i)) - f(sek(i-1))));
end
disp('Sekantenverfahren')
sek(length(sek))

% plot
figure('Name','NMIT1 - Serie 6, Aufgabe 1');
ezplot(f);
xlabel('x');
ylabel('y');
legend(sprintf('f(x) = %s', func2str(f)),'Location','NW');
grid on;
