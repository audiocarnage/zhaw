% NMIT2 - Serie 13, Aufgabe 10.3
% Das Signal hat eine endliche Länge von 0.005 Sekunden und wird in 
% 2n+1 diskrete Werte aufgeteilt.

format compact; format shortE; clear all; clc;

% Grundschwingung
nu = 200;   % [Hz]

% obere Intervallgrenze
tn = 0.005;

% Kreisfrequenz der Grundschwingung
omega = 2*pi*nu;

% Samplingrate 44.1 kHz
dt = 1/44.1e3;  % [s]

% diskrete Zeitschritte
ti = 0:dt:tn;

n = floor(numel(ti) / 2);
T = (ti(2*n)-ti(1));

f = @(t) sin(omega.*t) + 0.5 .* sin(4*omega.*t) + ...
    0.8 .* cos(2*omega.*t) + 0.4 .* cos(12*omega.*t);

y = f(ti);

[kp,Ak,Bk] = DFT(ti,y);
[Pk] = PowerSpektrum(Ak,Bk,n);

% Frequenzen
nui = kp/T;

t = 0:1e-6:tn;
figure;
subplot(2,2,1), plot(t,f(t),'r',ti,y,'ko');
xlabel('t [s]');
ylabel('f(t)');
grid on;
legend(func2str(f),'Samples','location','best');

subplot(2,2,2), plot(nui,Pk);
xlabel('Frequenz [Hz]');
ylabel('Power');
xlim([0 3000]);
grid on;

subplot(2,2,3), stem(nui,Ak);
xlabel('Frequenz [Hz]');
ylabel('A_k');
xlim([0 3000]);
grid on;

subplot(2,2,4), stem(nui,Bk);
xlabel('Frequenz [Hz]');
ylabel('B_k');
xlim([0 3000]);
grid on;
