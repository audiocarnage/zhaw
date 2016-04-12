% Script Georgiou_Remi_IT13t_S8_Aufg3
% 
% Gesuchtes Polynom von der Form : f(x) = a3 * x^3 + a2 * x^2 + a1 * x + a0
%
% Resultate:
% für b)
% In den Jahren 2003 und 2004 waren es 127 resp. 143 Tage mit starker UV-Belastung.
% für c)
% Die berechneten Koeffizienten sind identisch.
% p = [-0.3825    8.9900  -53.9875  195.3800]
% Somit sind die Funktionswerte für die Jahre 2003 und 2004 dieselben wie
% für Teilaufgabe b).


% Gleichungssystem aufstellen, um die Koeffizienten zu bestimmen
% 0 hoch 0 ist undefiniert. Siehe Mathematische Formelsammlung, Papula, Seite 10
% Darum entspricht in meiner Rechnung das Jahr 1996 der Zahl 0, 1997 der Zahl 1 usw...
A = [1 1 1 1; 27 9 3 1; 1000 100 10 1; 2744 196 14 1];
b = [150; 104; 172; 152];

% Koeffizienten meines Polynoms 3. Grades mittels Gauss-Elimination
% bestimmen (Funktion aus Übungsserie 7, Aufgabe 2)
[A_triangle,detA,koeff] = gauss(A,b);
koeff = koeff';

x = linspace(0,16);
jahre = [1 3 10 14];
tage = b';

% Polynom 3. Grades, das exakt durch die vier Datenpunkte verläuft
f = koeff(1) * x.^3 + koeff(2) * x.^2 + koeff(3) * x.^1 + koeff(4);

figure('Name','Serie 8 - Aufgabe 3');
subplot(2,1,1);

% plot f
line1 = plot(x,f,'r','LineWidth',2.5);
hold on;

% plot Beobachtungs-Datenpunkte
points = plot(jahre,tage,'b-o','LineWidth',1.5);

% Schätzwerte herausheben
% 2003 -> 7
% 2004 -> 8
schaetzwert2003 = polyval(koeff,7)
schaetzwert2004 = polyval(koeff,8)
point2003 = plot(7,schaetzwert2003,'ys','LineWidth',3);
point2004 = plot(8,schaetzwert2004,'ys','LineWidth',3);
hold off;

% X-Achsen-Beschriftung mit Original-Jahreszahlen
set(gca,'XTick',[0:16]);
set(gca,'XTickLabel',[1996:1:2012]);
xlabel('Jahr');
ylabel('Tage mit extremer UV-Belastung auf Hawaii');
legend([points,line1],'Beobachtungspunkte',...
    'p_1 x^3 + p_2 x^2 + p_3 x + p_4',...
    'Location','southeast');
grid on;

% c) Koeffizienten mittels Polyfit-Funktion bestimmen
p = polyfit(jahre,tage,3)
y = polyval(p,x);

% plot Polyfit-Polynom
subplot(2,1,2);
line2 = plot(x,y,'g','LineWidth',2.5);
hold on;
polyfit2003 = polyval(p,7)
polyfit2004 = polyval(p,8)
point2003 = plot(7,polyfit2003,'ys','LineWidth',3);
point2004 = plot(8,polyfit2004,'ys','LineWidth',3);
hold off;

% X-Achsen-Beschriftung mit Original-Jahreszahlen
set(gca,'XTick',[0:16]);
set(gca,'XTickLabel',[1996:1:2012]);
xlabel('Jahr');
ylabel('Tage mit extremer UV-Belastung auf Hawaii');
legend('Polyfit-Polynom','Location','southeast');
grid on;