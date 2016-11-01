% Funktion Georgiou_Remi_IT13t_S1_Aufg2_altenativ(a,xmin,xmax)
% Die Funktion hat 3 Rückgabewerte (Vektoren): y,ydiff,yint
% y,ydiff und yint sind von der Form [an an-1 an-2 ... a1 a0]
% a ist der Inputvektor, der die Polynomkoeffizienten enthält.
% a ist von der Form [a0 a1 a2 ... an]
% xmin ist die untere Intervallgrenze
% xmax ist die obere Intervallgrenze
% [xmin,xmax] = {x | xmin <= x <= xmax}
% Beispiel eines Funktionsaufrufes:
% [y,ydiff,yint] = Georgiou_Remi_IT13t_S1_Aufg2([0 0 1],0,5)

function[y,ydiff,yint] = Georgiou_Remi_IT13t_S1_Aufg2(a,xmin,xmax)

if isempty(a),
    error('ERROR: Der Eingabevektor enthält keine Werte.')
elseif ~isempty(a) && a(length(a)) == 0,
    error('ERROR: Ungültige Eingabe')
end

y = char(flip(a));

% Berechnung der Koeffizienten von ydiff
adiff = [];
for i=length(a):-1:2
    adiff = [adiff (a(i)*(i-1))];
end
ydiff = char(adiff);

% Berechnung der Koeffizienten von yint
aint = [];
for i=length(a):-1:1
    aint = [aint (1/i)*a(i)];
end
% Integrationskonstante C
C = 0;
aint = [aint C];
yint = char(aint);

x = linspace(xmin,xmax)

% plot y
plot(y,'b');
hold on;

% plot ydiff
plot(x,ydiff,'g');

% plot yint
plot(x,yint,'r');

x = -pi:pi/1000.1:pi;
plot(x,sin(x));

title('Serie 1 - Aufgabe 2');
xlim([xmin xmax]);
ylim('auto');
grid;
legend(strcat('f(x) = ',char(y)), ...
    strcat('f ''(x) = ',char(ydiff)),...
    strcat('F(x) = ',char(yint)),...
    'Location', 'northoutside');
hold off;
end