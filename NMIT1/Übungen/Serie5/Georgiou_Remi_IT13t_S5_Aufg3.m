% Script Georgiou_Remi_IT13t_S5_Aufg3

clear all;

% Volumen des Zylinders
Vz = 2000;

pi = 3.14159;

filling = 3/4;
syms phi r
s = solve(sin(phi)-phi == -0.5*pi, phi);
phiDeg = rad2deg(double(s));

% Füllhöhe numerisch berechnen nachdem r wertmässig bekannt ist.
h = 2*r - (r * (1 - cos(s./2)))
h = r * (1+cos(s./2))
area = pi * r^(2)
l = Vz / area

% Fixpunktiteration zur Bestimmung des Winkels phi
x = 2:0.001:2.5;

% Startwert
p(1) = 2.48009;

% Iterationsfunktion
F = sin(x) + 0.5*pi;

% Gerade
g = x;

% Fixpunktgleichung
for i=1:length(x)-1
    p(1+i) = sin(i) + (0.5*pi);
end

figure('Name','Serie 5 - Aufgabe 3,b)');
% plot Iterationsfunktion
line1 = plot(x,F,'b','LineWidth',2);
hold on;
% plot Gerade f(x) = x
line2 = plot(x,g,'r','LineWidth',2);
plot(p,x,'g','LineWidth',2);

% plot konvergierende Folge
point1 = plot(p,sin(p) + (0.5*pi),'dk','LineWidth',1.5);

% plot Fixpunkt
xhat = solve(g == F);
point2 = plot(xhat,xhat,'oy','LineWidth',3);

xlabel('x');
ylabel('y');
legend([line1,line2,point1,point2],'sin(x) + 0.5\pi','x',...
    'konvergierende Folge','Fixpunkt','Location','northoutside');
grid on;
hold off;
