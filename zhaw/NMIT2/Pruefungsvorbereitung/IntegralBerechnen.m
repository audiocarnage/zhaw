% Integral numerisch rechnen mittels den Newton-Cotes Formeln und den Gaussformeln
% - Summierte Rechteckformel
% - Summierte Trapezformel
% - Summierte Simpsonregel
% - Gaussformeln (das Integral 'optimal approximieren', h variabel)

format compact; format long; clear all; clc;

% Parameter
f = @(x) exp(-x.^2);
a = 0;
b = 0.5;
n = 3;
h = (b-a)/n


% Summierte Rechteckformel
Rf = 0;
for i=0:(n-1)
    Rf = Rf + f((a + i*h) + h/2);
end
Rf = h*Rf

% Summierte Trapezformel
Tf = 0;
for i=1:(n-1)
    Tf = Tf + f(a + i*h);
end
Tf = h * (((f(a) + f(b))/2) + Tf)

% Summierte Simpsonformel
Sf = f(a)/2;
for i=1:(n-1)
   Sf = Sf + f(a + i*h);
end
for i=1:n
   Sf = Sf + 2*f(((a + (i-1)*h) + (a + i*h))/2);
end
Sf = Sf + (f(b)/2);
Sf = h/3 * Sf

% Gaussformeln
G1f = (b-a) * f((b+a)/2)
G2f = (b-a)/2 * (f((-1/sqrt(3)*(b-a)/2) + ((b+a)/2)) + f((1/sqrt(3)*(b-a)/2) + ((b+a)/2)))
G3f = (b-a)/2 * (5/9 * f((-sqrt(0.6) * (b-a)/2) + (b+a)/2) + 8/9 * f((b+a)/2)) ...
    + (b-a)/2 * (5/9 * f((sqrt(0.6) * (b-a)/2) + (b+a)/2))

% Fehlerabschätzung
% 2. und 4. Ableitung berechnen
syms x
f2diff = matlabFunction(diff(f,x,2));
f4diff = matlabFunction(diff(f,x,4));

% finde das Funktionsmaximum auf dem Intervall [a,b] auf pragmatische Weise
abh = (b-a)*1e-6;
f2diffMaxAbs = max(abs(f2diff(a:abh:b)))
f4diffMaxAbs = max(abs(f4diff(a:abh:b)))

%errRf = (h^2)/24 * (b-a) * f2diffMaxAbs
%errTf = (h^2)/12 * (b-a) * f2diffMaxAbs
%errSf = (h^4)/2880 * (b-a) * f4diffMaxAbs
I =  double(int(f,x,a,b));
errRf = abs(I-Rf)
errTf = abs(I-Tf)
errSf = abs(I-Sf)
errG1f = abs(I-G1f)
errG2f = abs(I-G2f)
errG3f = abs(I-G3f)


figure;
x = linspace(a,b);
plot(x,f(x),x,f2diff(x),x,f4diff(x));
xlabel('x');
ylabel('y');
grid on;
legend(sprintf('Funktion %s', func2str(f)),...
        sprintf('2. Ableitung %s', func2str(f2diff)),...
        sprintf('4. Ableitung %s', func2str(f4diff)),'location','best');
