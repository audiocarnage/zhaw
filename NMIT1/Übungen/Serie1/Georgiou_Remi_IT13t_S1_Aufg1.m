% Script Georgiou_Remi_IT13t_S1_Aufg1
% Grafische Darstellung einer Funktion f(x), Ableitungsfunktion f'(x)
% und Stammfunktion F(x)
% Annahme für angegebenes Intervall:
% [a,b] = {x | a <= x <= b}, mit a = -10 und b = 10

x = linspace(-10,10);

f = x.^5 - 5*x.^4 - 30*x.^3 + 110*x.^2 + 29*x - 105;
g = 5*x.^4 - 20*x.^3 - 90*x.^2 + 220*x + 29;
h = 1/6*x.^6 - x.^5 - 7.5*x.^4 + 110/3*x.^3 + 14.5*x.^2 - 105*x;

plot(x,f,x,g,x,h,'LineWidth',2);
title('Serie 1 - Aufgabe 1');
xlim([-8 10]);
ylim([-2800 1500]);
grid;
legend('f (x) = x^5 - 5x^4 - 30x^3 + 110x^2 + 29x - 105',...
    'f ''(x) = 5x^4 - 20x^3 - 90x^2 + 220x + 29',...
    'F(x) = 1/6x^6 - x^5 - 15/2x^4 + 110/3x^3 + 29/2x^2 - 105x',...
    'Location', 'northoutside');

% Zur Veranschaulichung werden die Nullstellen von f(x) markiert.
hold on;
x0 = [-5 -1 1 3 7];
ymarkers = polyval([1 -5 -30 110 29 -105],x0);
plot(x,f,'k',x0,ymarkers,'sk','MarkerSize',8);
hold off;