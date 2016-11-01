% Funktion Georgiou_Remi_IT13t_S1_Aufg2(a,xmin,xmax)
% Die Funktion hat 3 Rückgabewerte (Vektoren): y,ydiff,yint
% y,ydiff,yint sind von der Form [an an-1 an-2 ... a1 a0]
% a ist der Inputvektor, der die Polynomkoeffizienten enthält.
% a ist von der Form [a0 a1 a2 ... an]
% xmin ist die untere Intervallgrenze
% xmax ist die obere Intervallgrenze
% [xmin,xmax] = {x | xmin <= x <= xmax}
% Beispiel eines Funktionsaufrufes:
% [y,ydiff,yint] = Georgiou_Remi_IT13t_S1_Aufg2([3 0 1.5],0,5)

function[y,ydiff,yint] = Georgiou_Remi_IT13t_S1_Aufg2(a,xmin,xmax)

[m,n] = size(a);
if isempty(a),
    error('ERROR: Der Eingabevektor enthält keine Werte.')
elseif (~isempty(a) && a(length(a)) == 0) || m ~= 1,
    error('ERROR: Ungültige Eingabe')
end

% Berechnung der Koeffizienten von ydiff
kdiff = [];
for i=2:1:n
    kdiff = [kdiff (a(i)*(i-1))];
end

% Berechnung der Koeffizienten von yint
kint = [];
for i=length(a):-1:1
    kint = [kint (1/i)*a(i)];
end
% Integrationskonstante C
C = 0;
kint = [kint C];

% Zur Darstellung der Funktionen verwende ich fplot.
% fplot() funktioniert für meinen Anwendungsfalls besser als plot()

% plot y
y = poly2sym(flip(a));
if length(a) == 1
    x = linspace(xmin,xmax);
    plot(x,a,'b');
elseif length(a) > 1
    h = matlabFunction(y);
    fplot(h,[xmin xmax],'b');
end
hold on;

% plot ydiff
ydiff = poly2sym(flip(kdiff));
if length(kdiff) == 1,
    x = linspace(xmin,xmax);
    plot(x,kdiff,'g');
elseif length(kdiff) > 1
    h = matlabFunction(ydiff);
    fplot(h,[xmin xmax],'g');
end

% plot yint
yint = poly2sym(kint);
h = matlabFunction(yint);
fplot(h,[xmin xmax],'r');

title('Serie 1 - Aufgabe 2');
xlim([xmin xmax]);
ylim('auto');
grid;
legend(strcat('f(x) = ',char(y)), ...
    strcat('f ''(x) = ',char(ydiff)),...
    strcat('F(x) = ',char(yint)),...
    'Location', 'northoutside');
hold off;

% output vectors
y = sym2poly(y);
ydiff = sym2poly(ydiff);
yint = sym2poly(yint);
end