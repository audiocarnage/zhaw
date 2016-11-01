% NMIT2- Serie 3, Aufgabe 1
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)

format compact; format short; clear all; clc;

%f = @(x) log(x.^2);
f = @(x) sin(x.^2);
syms x
f2diff = matlabFunction(diff(f,x,2));

%a = 1;
%b = 2;
a = 0;
b = pi;
abh = (b-a)*1e-6;
MAX_FEHLER = 1e-6;

% finde das Funktionsmaximum auf dem Intervall [a,b] auf pragmatische Weise
yMax = max(abs(f2diff(a:abh:b)))

% Trapezregel
hTrapez = sqrt(12 * MAX_FEHLER / ((b-a) * yMax));
nTrapez = ceil((b-a)/hTrapez);

% Rechteckregel
hRechteck = sqrt(24 * MAX_FEHLER / ((b-a) * yMax));
nRechteck = ceil((b-a)/hRechteck);

% Simpsonregel
f4diff = matlabFunction(diff(f,x,4));
yMax = max(abs(f4diff(a:abh:b)));
hSimpson = (2880 * MAX_FEHLER / ((b-a) * yMax)).^(1/4);
nSimpson = ceil((b-a)/hSimpson);

fprintf('Integrationsverfahren \t Schrittweite h \t Subintervalle n \n')
fprintf('************************************************************\n')
fprintf('Rechteckregel \t\t\t %.10f \t\t %i \n', hRechteck, nRechteck)
fprintf('Trapezregel \t\t\t %.10f \t\t %i \n', hTrapez, nTrapez)
fprintf('Simpsonregel \t\t\t %.10f \t\t %i \n', hSimpson, nSimpson)

x = linspace(a,b);
figure;
subplot(1,2,1), plot(x,abs(f2diff(x)));
xlabel('x');
ylabel('y');
grid on;
legend(func2str(f2diff),'location','best');

subplot(1,2,2), plot(x,abs(f4diff(x)));
xlabel('x');
ylabel('y');
grid on;
legend(func2str(f4diff),'location','best');
