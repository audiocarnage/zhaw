% Script Georgiou_Remi_IT13t_S2_Aufg3
%
% Beobachtungen zur Teilaufgabe a)
% Die beste Annäherung erhält man mit n = 786432. Hier stimmt die 
% Annäherung in den ersten 6 Nachkommastellen überrein.
% Für n > 786432 nimmt die Annäherung wieder ab.
% Für eine 10-stellige Gleitpunktarithmetik und grösser, 
% ist rd(2n * s2n) = 0. Der Faktor s2n wird kleiner als die Maschinen-
% genauigkeitszahl tau (1.110223024625157E-16) auf diesem Computersystem.
%
% Beobachtungen zur Teilaufgabe b)
% Der Algorithmus ist robuster. Bei der Eingabe von grossen n (> 1e9)
% stimmt die Annäherung in den ersten 14 Nachkommastellen überrein.

format long;
format compact;
radius = 1;
sn = radius;
n = 6
s2n = 0;
nmax = 1e9;
xhat = n*radius;
abserror = abs(xhat - (2*pi))

% Teilaufgabe a)
% plot using s2n = sqrt(2-sqrt(4-power(sn,2)))
subplot(2,1,1);
hold on;
while (n < nmax)
    s2n = sqrt(2-sqrt(4-power(sn,2)));
    plot(2*n,2*n*s2n,'-o','MarkerEdgeColor',[0 .2 .5],...
              'MarkerFaceColor',[0 .5 .7]);
    n = 2*n;
    xhat = n*s2n;
    n;
    abserror = abs(xhat - (2*pi));
    '----------';
    sn = s2n;
end

grid on;
title('Serie 2 - Aufgabe 3,a)');
legend('2n * s2n','Location', 'northoutside');
hold off;

% Teilaufgabe b)
% plot using s2n = sqrt(0.5 * power(sn,2)/(1 + sqrt(1-(power(sn,2)/4))))
subplot(2,1,2);
hold on;
sn = radius;
n = 6;
s2n = 0;
while (n < nmax)
    s2n = sqrt(power(sn,2)/(2*(1 + sqrt(1-(power(sn,2)/4)))));
    plot(2*n,2*n*s2n,'-o','MarkerEdgeColor',[.22 .45 .04],...
              'MarkerFaceColor',[.49 1 .37]);
    n = 2*n;
    xhat = n*s2n;
    n
    abserror = abs(xhat - (2*pi))
    '----------'
    sn = s2n;
end

grid on;
title('Serie 2 - Aufgabe 3,b)');
legend('2n * s2n','Location', 'northoutside');
hold off;
