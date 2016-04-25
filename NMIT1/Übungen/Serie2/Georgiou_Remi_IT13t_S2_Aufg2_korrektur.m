% Script Georgiou_Remi_IT13t_S2_Aufg2_korrektur
%
% Beobachtungen zur Teilaufgabe a)
% In der Umgebung von x = 2 erkennt man, wie die Rundungsfehler der
% Maschinenzahlen zu einer Zackenlinie im Graphen führen.
%
% Beobachtungen zur Teilaufgabe b)
% Die numerische Berechnung des Grenzwertes lim x->0 für g(x) ist zu
% ungenau (nicht stabil). Die analytische Lösung ergibt 1.
%
% Beobachtungen zur Teilaufgabe c)
% Ich gehe davon aus, dass durch Umformung des Nenners die numerische
% Berechnung des Grenzwertes stabil wird, d.h., dass lim x->0 für g(x) den
% Wert 1 annimmt.

% Teilaufgabe a)
x = linspace(1.99,2.01,501);
f1 = x.^7 - 14*x.^6 + 84*x.^5 - 280*x.^4 + ...
        560*x.^3 - 672*x.^2 + 448*x - 128;
f2 = (x-2).^7;

subplot(2,1,1);
plot(x,f1,'b',x,f2,'r')
title('Serie 2 - Aufgabe 2,a)');
legend('f(x) = x^7 - 14x^6 + 84x^5 - 280x^4 + 560x^3 - 672x^2 + 448x - 128',...
    'f(x) = (x-2)^7','Location', 'northoutside');

% Teilaufgabe b)
lower = -1e-14;
upper = 1e-14;
schrittweite = 1e-17;
d = upper - lower;
schritte = d / schrittweite;

x = linspace(lower,upper,schritte);
g = x./(sin(1+x) - sin(1));
limes_g = 1/cos(0);

subplot(2,1,2);
plot(x,g,'g',x,limes_g,'r','LineWidth',2);
ylim([0 3]);
title('Serie 2 - Aufgabe 2,b),c)');
xlabel('x');
ylabel('g(x) = x/(sin(1+x) - sin(1))');
legend('g(x) = x/(sin(1+x) - sin(1))','Location','northoutside');

x = upper:0.001:1;
h = (exp(x)-1)/x;
subplot(3,1,3);
plot(x,h,'g','LineWidth',3);
xlabel('x');
ylabel('h(x) = (exp(x) - 1/x');
legend('h(x) = (e^x - 1)/x','Location','northoutside');

% Teilaufgabe c)
h = 0.5 * x./(cos((2+x)/2)*sin((x)/2));
subplot(3,1,3);
plot(x,h,'m','LineWidth',3);