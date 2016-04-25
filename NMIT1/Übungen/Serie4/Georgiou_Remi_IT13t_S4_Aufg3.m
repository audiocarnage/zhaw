% Skript Georgiou_Remi_IT13t_S4_Aufg3
%
% Mit kleiner werdender Toleranz steigt die Anzahl Iterationen
% logarithmisch an. Ab einer Toleranz kleiner als 1E-15 verabschiedet sich 
% die Funktion ins Unendliche. Toleranzen von kleiner als 1E-15 sind 
% nicht mehr relevant, d.h. die Stabilität des Algorithmus zu Bestimmung 
% des Näherungswertes der gesuchten Nullstelle wird durch 
% die Maschinengenauigkeit limitiert.
%
% Bei gegebener Toleranz von 1E-15 erreicht das Bijektionsverfahren 
% nach etwa 13 Iterationen die grösste Genauigkeit. Der Näherungswert wird
% von da an nicht mehr genauer bestimmt und die Berechnung kann im Prinzip 
% bei n = 15 beendet werden.
%
% Für x^2-2 und logarithmisch skalierter Y-Achse verläuft die Annäherung 
% an die Nullstelle nicht linear. Der Graph einer anderen Funktion, 
% z.B. x^(3) + sinx(x) [root_exact = 0], ergab jedoch eine
% charakteristische Gerade mit einem Knickpunkt bei y = 1E-15.

format longE;
f = @(x) x.^(2)-2;
root_exact = sqrt(2)
a = 0;
b = 2;

% Grafik mit Toleranz 1E-15
tol = 1E-15;
[root,xit,n] = Georgiou_Remi_IT13t_S4_Aufg2(f,a,b,tol);
x = 1:1:n;
y = [];
for i=1:1:length(xit)
    y = [y abs(xit(i) - root_exact)];
end

figure('Name','Serie 4 - Aufgabe 3');
subplot(1,2,1);
semilogy(x,y,'m','LineWidth',1.5);
ylim('auto');
xlabel('Anzahl Iterationen');
ylabel('|root - exakte Nullstelle|');
legend(['Absoluter Fehler als Funktion von Anzahl Iterationen, '...
    'Toleranz = ' num2str(tol)],'Location','northoutside');

% Grafik mit Toleranz 1E-16
tol = 1E-16;
[root,xit,n] = Georgiou_Remi_IT13t_S4_Aufg2(f,a,b,tol);
x = 1:1:n;
y = [];
for i=1:1:length(xit)
    y = [y abs(xit(i) - root_exact)];
end
subplot(1,2,2);
semilogy(x,y,'b','LineWidth',1.5);
ylim('auto');
xlabel('Anzahl Iterationen');
ylabel('|root - exakte Nullstelle|');
legend(['Absoluter Fehler als Funktion von Anzahl Iterationen, '...
    'Toleranz = ' num2str(tol)],'Location','northoutside');


% Darstellung der Anzahl benötiger Iterationen n
% als Funktion der geforderten Toleranz tol.
% tol in {10^-1,10^-2,...,10^-20}
figure('Name','Serie 4 - Aufgabe 3');
x = [];
y = [];
for i=-1:-1:-20
    tol = 10^(i);
    x = [x tol];
    [root,xit,n] = Georgiou_Remi_IT13t_S4_Aufg2(f,a,b,tol);
    y = [y n];
end

% In der Aufgabenstellung steht, man soll die loglog-Funktion zum Plotten
% verwenden. Ich persönlich finde aber die Darstellung mit logarithmischer 
% X-Achse anschaulicher für n <= 100.
semilogx(x,y,'r','LineWidth',2);
set(gca,'Xdir','reverse');
xlabel('Toleranz');
ylabel('Anzahl Iterationen');
legend('Anzahl Iterationen als Funktion der Toleranz','Location','northoutside');
