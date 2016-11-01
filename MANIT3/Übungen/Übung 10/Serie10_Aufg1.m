% Serie 10, Aufgabe 1

format compact; format short; clear all; clc;

p = 0.75;
n = 10;

figure();
subplot(1,2,1);
x1 = 0:10;
y1 = binocdf(x1,n,p);
bar(x1,y1,0.2);
grid on;

subplot(1,2,2);
x2 = 0:6;
y2 = 1-binocdf(x2,n,p)
bar(x2,y2,0.2);
grid on;

fprintf('P(X >= 7) = %1.5f\n', 1-binocdf(6,n,p));