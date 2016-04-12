% SEP NMIT2, Aufgabe 5

format compact; format long; clear all; clc;

% Grundschwingung
nu = 120;   % [Hz]

% obere Intervallgrenze
tn = 0.04;

% Kreisfrequenz der Grundschwingung
omega = 2*pi*nu;

% Samplingrate 1500 Hz
dt = 1/1500;  % [s]

% diskrete Zeitschritte
ti = 0:dt:tn;

n = floor(numel(ti) / 2);
T = (ti(2*n)-ti(1));

f = @(t) 0.3 + sin(omega.*t) + 0.2.*cos(9*omega.*t);

y = f(ti);

[kp,Ak,Bk] = DFT(ti,y);


% b)  inverse DFT berechnen
omega0 = 2*pi/0.04;
fhut = @(t) Ak.*cos(kp.*omega0.*t) + Bk.*sin(kp.*omega0.*t)

% Frequenzen
nui = kp/T;

t = 0:1e-4:tn;
figure;
subplot(2,2,1), plot(t,f(t),'r',ti,y,'ko');
xlabel('t [s]');
ylabel('f(t)');
grid on;
legend(func2str(f),'Samples','location','best');

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