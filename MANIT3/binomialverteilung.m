% Binomialverteilung

format compact; format short; clear all; clc;

figure;

subplot(1,3,1);
x = 0:5;
y = binopdf(x,5,0.3);
bar(x,y,0.2);

subplot(1,3,2);
x = 0:20;
y = binopdf(x,20,0.3);
bar(x,y,0.2);

subplot(1,3,3);
x = 0:80;
y = binopdf(x,80,0.4);
bar(x,y,0.2);
