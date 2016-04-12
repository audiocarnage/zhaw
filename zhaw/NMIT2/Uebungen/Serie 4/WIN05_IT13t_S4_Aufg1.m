% NMIT2 - Serie 4, Aufgabe 1
% @author Georgiou Rémi (georgrem), Stocker André (stockan1)

clear all; format shortE; clc;

% a)
t = 0:10:120;
h = [2 286 1268 3009 5375 8220 11505 15407 20127 25593 31672 38257 44931];
m = [2051113 1935155 1799290 1681120 1567611 1475282 1376301 1277921 1177704 1075683 991872 913254 880377];

v = WIN05_IT13t_S1_Aufg3a(t,h);
a = WIN05_IT13t_S1_Aufg3a(t,v);
dmdt = WIN05_IT13t_S1_Aufg3a(t,m);
dmdh = WIN05_IT13t_S1_Aufg3a(h,m);

figure('name','NMIT2 -   Serie 4, Aufgabe 1 a)');
% Ortskurve
subplot(3,3,1);
plot(t,h,'g-o','LineWidth',2);
title('Höhe');
xlabel('t [s]');
ylabel('h(t) [m]');
grid on;

% Geschwindigkeit
subplot(3,3,2);
plot(t,v,'b-o','LineWidth',2);
title('Geschwindigkeit');
xlabel('t [s]');
ylabel('v(t) [m/s]');
grid on;

% Beschleunigung
subplot(3,3,3);
plot(t,a,'r-o','LineWidth',2);
title('Beschleunigung');
xlabel('t [s]');
ylabel('a(t) [m/s^2]');
grid on;

% Massenveränderungen
subplot(3,3,4);
plot(t,m,'c:x','LineWidth',2);
title('Massenänderung');
xlabel('t [s]');
ylabel('m(t) [kg]');
grid on;

subplot(3,3,5);
plot(t,dmdt,'c:x','LineWidth',2);
title('Massenänderung');
xlabel('t [s]');
ylabel('dm/dt [kg/s]');
grid on;

subplot(3,3,6);
plot(h,dmdh,'c:x','LineWidth',2);
title('Massenänderung');
xlabel('h [m]');
ylabel('dm/dh [kg/m]');
grid on;

subplot(3,3,7);
plot(t,dmdt,'r:','LineWidth',3);
title('Check dm/dt = dm/dh * dh/dt');
hold on;
plot(t,dmdh.*v,'k','LineWidth',1);
hold off;
xlabel('t [s]');
ylabel('dm/dt [kg/s]');
legend('dm/dt','dm/dh * v(t)','Location','SW');
grid on;


% b)
R0 = 603780137;
M = 5.976e24;
G = 6.673e-11;

R = R0 + h;
f =  m./(R.^(2));

Epot = G * M * WIN05_IT13t_S3_Aufg4a(R,f);
Ekin = WIN05_IT13t_S3_Aufg4a(R,dmdt.*v) + WIN05_IT13t_S3_Aufg4a(R,m.*a);
Etot = Epot + Ekin;

figure('name','NMIT2 - Serie 4, Aufgabe 1 b)');
%subplot(3,1,1);
plot(t(1:length(Ekin)),Ekin,'r-o','LineWidth',2);
%xlabel('t [s]');
%ylabel('E_{kin}(t) [J]');
%grid on;
%subplot(3,1,2);
hold on;
plot(t(1:length(Epot)),Epot,'b-o','LineWidth',2);
%xlabel('t [s]');
%ylabel('E_{pot}(t) [J]');
%grid on;
%subplot(3,1,3);
plot(t(1:length(Etot)),Etot,'k-o','LineWidth',2);
xlabel('t [s]');
ylabel('E = E_{kin}(t) + E_{pot}(t) [J]');
grid on;
hold off;
