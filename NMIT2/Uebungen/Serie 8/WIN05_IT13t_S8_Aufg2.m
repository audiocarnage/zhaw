% @author Rémi Georgiou (georgrem), André Stocker (stockan1)

format compact; format shortE; clc;

% Parameter
c = 0.16;   % [Ns/m], Dämpfungskoeffizient
m = 1;      % [kg], Masse
l = 1.2;    % [m], Länge des Fadens
g = 9.81;   % [m/s^2], Erdbeschleunigung
a = 0;
b = 60;
deltaT = 0.1;
n = (b-a)/deltaT;

% DGL
diff2_phi = @(t,z) [z(2) ; z(2)*(-c/m) - sin(z(1))*(-g/l)];

% Anfangsbedinung
phi0 = [pi/2; 0];

% Phi mit vierstufigem Runge-Kutta Verfahren berechnen.
[t,phi] = WIN05_IT13t_S6_Aufg1(diff2_phi,a,b,n,phi0);

% plot
figure('name','NMIT2 - Serie 8, Aufgabe 2');
plot(t,phi(1,:),'b','LineWidth',2);
title('');
xlabel('t [s]');
ylabel('\psi(t)');
grid on;
