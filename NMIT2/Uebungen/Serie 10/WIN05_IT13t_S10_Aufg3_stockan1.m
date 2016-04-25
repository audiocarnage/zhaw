% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 10, Aufgabe 3
% Interpolation durch eine Splinefunktion

clc; clear all; format shortE; format compact;

x = [1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000];
y = [75.995 91.972 105.711 123.203 131.669 150.697 179.323 203.212 226.505 249.633 281.422];
xx = 1940:5:1950;

yy1 = WIN05_IT13t_S10_Aufg2_stockan1(x,y,xx)
yy2 = spline(x,y,xx)
figure, subplot(1,2,1), plot(x,y,xx,yy1,'--',xx,yy2,':');
legend('f(x)','Natural cubic spline','MATLAB spline()');
xlabel('$x$','fontsize',18,'interpreter','latex'); ylabel('$f(x)$','fontsize',18,'interpreter','latex')
title('Natural cubic spline vs  MATLAB spline()','fontsize',18,'interpreter','latex');

x1 = x-x(1);
P = polyfit(x1,y,10);
y2 = polyval(P,x1);
subplot(1,2,2), plot(x,y2);
xlabel('$x$','fontsize',18,'interpreter','latex'); ylabel('$f(x)$','fontsize',18,'interpreter','latex')
title('MATLAB polyfit()','fontsize',18,'interpreter','latex');