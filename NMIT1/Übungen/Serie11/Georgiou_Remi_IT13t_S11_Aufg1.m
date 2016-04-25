% Script Georgiou_Remi_IT13t_S11_Aufg1
% Die Funktion W beschreibt die Wurfweite eines Körpers, der mit der
% Anfangsgeschwindigkeit v0 unter einem Winkel a gegen die Horizontale
% abgeworfen wird.
% 
% W wird bei v0=100 und einem Winkel alpha von 0.7854 (45°) maximal.

v0 = 0:1:100;
alpha = linspace(0,(pi/2),101);
g = 9.81;

[v,a] = meshgrid(v0,alpha);

% Anonyme Funktion: Wurfweite eines Körpers
W = @(v,a) (v.^(2).*sin(a.*2))/g;

% Berechnung des Winkels alpha, bei welchem mit gegebenem v0=100 
% W maximal wird
wmax = max(W(100,a));
syms alpha_max
amax = solve(wmax(1) == (100^(2)*sin(alpha_max*2))/g, alpha_max)

% plots
figure('Name','Dreidimensionale Darstellung mit Höhenlinien')
meshc(v,a,W(v,a)), view(40,20);
title('Dreidimensionale Darstellung mit Höhenlinien');
xlabel('Anfangsgeschwindigkeit [ms^-1]')
ylabel('Winkel alpha im Bogenmass')
zlabel('Wurfweite [m]')
grid on
colormap jet

figure('Name','Contour-Darstellung der Höhenlinien in 2D')
contour(v,a,W(v,a),'ShowText','on');
title('Contour-Darstellung der Höhenlinien in 2D');
xlabel('Anfangsgeschwindigeit [ms^-1]')
ylabel('Winkel alpha im Bogenmass')
grid off
colormap jet

figure('Name','Ebene')
surface(v,a,W(v,a)), view(2);
c = colorbar;
title(c,'Wurfweite [m]');
title('Ebene')
xlabel('Anfangsgeschwindigkeit [ms^-1]')
ylabel('Winkel alpha im Bogenmass')
colormap jet
