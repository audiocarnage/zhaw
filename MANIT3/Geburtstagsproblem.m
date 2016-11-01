format short; format compact; clear all; clc;

fprintf('Geburtstagsproblem\n')
N = 365;
x = 75;
nr = 1:x;
nr = nr';
pr = 1:x;
pr = pr';
for j = 2:nr(length(nr))
    pr(j) = pr(j-1)*(1-(j-1)/365);
end;
A = [nr 1-pr]

figure;
plot(nr,1-pr);
xlabel('Anzahl Personen');
ylabel('Wahrscheinlichkeit');
grid on;

% Allgemeine Lösungsformel (approximatif)
n = sqrt(log(2)*2*N)

% Kollision mit einem bestimmten Hashwert
n_kollision = N * log(2)