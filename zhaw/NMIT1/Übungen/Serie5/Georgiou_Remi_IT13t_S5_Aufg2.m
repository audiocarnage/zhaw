% Script Georgiou_Remi_IT13t_S5_Aufg2
% "Grippeausbreitung im Kindergarten"
%
% a)
% Bei einer Infektionsrate alpha=1.5 und Startwert k0 = 0.1 konvergiert 
% die Folge gegen den Fixpunkt 1/3.
% b)
% Der Fixpunkt ist der Schnittpunkt der Geraden g(x) = x und der
% Iterationsfunktion F(x).
% c)
% Iterationsfunktion x = F(x) = ax(1-x)
% => x = ax-x^2 => ax-x-ax^2 = 0 => a-1-ax = 0 => (a-1)/a - x = 0
% => x = (a-1)a

clear all;
x = 0:0.01:0.5;

% Infektionsrate
alpha = 1.5;

% Iterationsfunktion: konkave Parabel
F = alpha*x.*(1-x);
% Gerade
g = x;

figure('Name','Serie 5 - Aufgabe 2');
% plot Iterationsfunktion
line1 = plot(x,F,'b','LineWidth',2);
hold on;
% plot Gerade f(x) = x
line2 = plot(x,g,'r','LineWidth',2);

% Startwert: 10% erkrankte Kinder
k(1) = 0.1;

% Grippeausbreitung
for i=1:length(x)-1
    k(1+i) = alpha*k(i)*(1-k(i));
end

% plot konvergierende Folge
point1 = plot(k,alpha*k.*(1-k),'dk','LineWidth',1.5);

% plot Fixpunkt
xhat = k(length(k));
point2 = plot(xhat,xhat,'oy','LineWidth',3);

xlabel('x');
ylabel('y');
legend([line1,line2,point1,point2],'\alphax(1-x)','x',...
    'Grippeausbreitung','Fixpunkt [(\alpha-1)/\alpha]','Location','northoutside');
grid on;
hold off;
