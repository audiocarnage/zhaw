% optimale Schrittweite für numerische Integration berechnen

format compact; format long; clear all; clc;

% Parameter
f = @(x) exp(-(x.^2));
a = 0;
b = 0.5;
abh = (b-a)*1e-6;
MAX_FEHLER = 1e-5;


% 2. und 4. Ableitung berechnen
syms x
f2diff = matlabFunction(diff(f,x,2));
f4diff = matlabFunction(diff(f,x,4));

% finde das Funktionsmaximum auf dem Intervall [a,b] auf pragmatische Weise
f2diffMax = max(abs(f2diff(a:abh:b)))
f4diffMax = max(abs(f4diff(a:abh:b)))

% Fehlerabschätzung
% Trapezregel
hTrapez = sqrt(12 * MAX_FEHLER / ((b-a) * f2diffMax));
nTrapez = ceil((b-a)/hTrapez);
% Rechteckregel
hRechteck = sqrt(24 * MAX_FEHLER / ((b-a) * f2diffMax));
nRechteck = ceil((b-a)/hRechteck);
% Simpsonregel
hSimpson = (2880 * MAX_FEHLER / ((b-a) * f4diffMax)).^(1/4);
nSimpson = ceil((b-a)/hSimpson);

fprintf('Integrationsverfahren \t Schrittweite h \t Subintervalle n \n')
fprintf('************************************************************\n')
fprintf('Rechteckregel \t\t\t %.10f \t\t %i \n', hRechteck, nRechteck)
fprintf('Trapezregel \t\t\t %.10f \t\t %i \n', hTrapez, nTrapez)
fprintf('Simpsonregel \t\t\t %.10f \t\t %i \n', hSimpson, nSimpson)


figure;
x = linspace(a,b);
plot(x,f(x),x,abs(f2diff(x)),x,abs(f4diff(x)));
xlabel('x');
ylabel('f(x)');
grid on;
legend(func2str(f),func2str(f2diff),func2str(f4diff),'location','best');
