% NMIT2 - Serie 11, Aufgabe 2
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)

format compact; format short; clear all; clc;

data = [33.00 53.00 3.32 3.42 29.00
        31.00 36.00 3.10 3.26 24.00
        33.00 51.00 3.18 3.18 26.00
        37.00 51.00 3.39 3.08 22.00
        36.00 54.00 3.20 3.41 27.00
        35.00 35.00 3.03 3.03 21.00
        59.00 56.00 4.78 4.57 33.00
        60.00 60.00 4.72 4.72 34.00
        59.00 60.00 4.60 4.41 32.00
        60.00 60.00 4.53 4.53 34.00
        34.00 35.00 2.90 2.95 20.00
        60.00 59.00 4.40 4.36 36.00
        60.00 62.00 4.31 4.42 34.00
        60.00 36.00 4.27 3.94 23.00
        62.00 38.00 4.41 3.49 24.00
        62.00 61.00 4.39 4.39 32.00
        90.00 64.00 7.32 6.70 40.00
        90.00 60.00 7.32 7.20 46.00
        92.00 92.00 7.45 7.45 55.00
        91.00 92.00 7.27 7.26 52.00
        61.00 62.00 3.91 4.08 29.00
        59.00 42.00 3.75 3.45 22.00
        88.00 65.00 6.48 5.80 31.00
        91.00 89.00 6.70 6.60 45.00
        63.00 62.00 4.30 4.30 37.00
        60.00 61.00 4.02 4.10 37.00
        60.00 62.00 4.02 3.89 33.00
        59.00 62.00 3.98 4.02 27.00
        59.00 62.00 4.39 4.53 34.00
        37.00 35.00 2.75 2.64 19.00
        35.00 35.00 2.59 2.59 16.00
        37.00 37.00 2.73 2.59 22.00];

% Anfangstemperatur
TTank = data(:,1);
% Temperatur des eingefüllten Benzins
TBenzin = data(:,2);
% Gasdruck im Tank
pTank = data(:,3);
% Gasdruck des eingefüllten Benzins
pBenzin = data(:,4);
% y = mch, Masse der ausströmenden Gase
mch = data(:,5);

A = [TTank TBenzin pTank pBenzin ones(size(mch))];

% Fehlergleichungssystem lösen
lambda = (A'*A)\(A'*mch);

n = numel(mch);
x = 0:n-1;
p = A*lambda;

% a)
figure('name','NMIT2 - Aufgabe 11, Aufgabe 2');
subplot(1,2,1), plot(x,mch','o',x,p','k-');
title('Masse der entweichenden Kohlenwasserstoffdämpfe');
xlabel('x');
ylabel('Masse m_{CH} [g]');
grid on;

% b)
% Definition Fehlerfunktional:  E(f) = 2-norm(y-f(x))^2
fehlerkategorien = 10;
durchgaenge = 1000;
min_Fehlerfunktional = zeros(1, fehlerkategorien);
max_Fehlerfunktional = zeros(1, fehlerkategorien);

% wachsende relative Fehlern: 1% ... 10%
for i=1:fehlerkategorien
    y_disturbed = zeros(n, durchgaenge);
    fehlerfunktional = zeros(1, durchgaenge);
    for j=1:durchgaenge
		y_disturbed(:,j) = mch + ((mch * (i/100)).* sign(rand(n,1)-0.5));
        % analog zu NMIT2, Kapitel 4 Fehlerrechnung bei linearen Gleichungssystemen
        % Ãx = b_tilde
        lambda_disturbed = (A'*A)\(A'*y_disturbed(:,j));
        fehlerfunktional(j) = norm((y_disturbed(:,j) - (A*lambda_disturbed)),2)^2;
    end
	% min. und max. Fehlerfunktional pro Fehlerkategorie bestimmen
	min_Fehlerfunktional(i) = min(fehlerfunktional);
	max_Fehlerfunktional(i) = max(fehlerfunktional);
end

subplot(1,2,2), plot(1:fehlerkategorien, min_Fehlerfunktional, 'r-o',...
    1:fehlerkategorien, max_Fehlerfunktional, 'g-o');
title('+/- 1%...10%, 1000 Durchläufe pro Fehlerkategorie');
xlabel('Fehlerkategorie [%]');
ylabel('Fehlerfunktional');
legend('min. Fehlerfunktional', 'max. Fehlerfunktional', 'location','NW');
grid on;
