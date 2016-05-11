% MANIT3 - Serie 16, Aufg. 1

format compact; format short; clear all; clc;

% a)
quartil = 0.5;
syms x
s = double(solve((0.63-0.2)/(900-600) == (quartil-0.2)/(x-600),x))

% b)
N = 2000;
xedge = [300 500 600 900 1300 1800 2500];
hi = [N*0.12 400-240 1260-400 1620-1260 1840-1620 N-1840]
Fi = [0.12 0.2 0.63 0.81 0.92 1.0];
fi = [0.12 0.2-0.12 0.63-0.2 0.81-0.63 0.92-0.81 1.0-0.92]
deltax = [200 100 300 400 500 700];
Di = [hi./deltax 0]  % Dichte
di = [fi./deltax 0]

figure('name','MANIT3 - Übung 1 - Aufgabe 3');
bar(xedge,Di,'histc','g');
xlabel('x');
ylabel('Dichte');
legend('Häufigkeiten','location','best');
grid on;
