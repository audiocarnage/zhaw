% NMIT2 - Serie 4, Aufgabe 2
% @author Georgiou Rémi, Stocker André

format compact; format shortE; clc;

% a)

% Zeit [s]
t = linspace(0,0.05,50);

% Spannung [V]
V = @(t) 3500 * sin(140*t.*pi).*exp(-63*t.*pi);

figure('name','NMIT2 - Serie 4, Aufgabe 2');
subplot(1,2,1);
plot(t,V(t),'b','LineWidth',1.5);
title('Puls eines Defibrillators');
xlabel('t [ms]');
ylabel('Spannung V(t) [V]');
legend('3500 \cdot sin(140\pit) \cdot e^{-63\pit}','Location','NE');
grid on;

% elektrischer Widerstand eines Patienten 50 Ohm
ElectricalPower = @(t) ((3500 * sin(140*t.*pi).*exp(-63*t.*pi)).^(2))/50;

Energy = zeros(1,length(t));
index = 1;
for i=0.001:1e-3:50e-3
    Energy(index) = WIN05_IT13t_S3_Aufg3(ElectricalPower,0,i,3);
    index = index + 1;
end

subplot(1,2,2);
plot(t,Energy,'r','LineWidth',1.5);
title('Elektrische Energie abgegeben vom Defibrillator');
xlabel('t [ms]');
ylabel('Energie E(t) [J]');
grid on;


