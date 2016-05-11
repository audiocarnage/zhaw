% MANIT3 - Serie 14, Aufgabe 8

format compact; format short; clear all; clc;

x = unifrnd(0,10,60,200);

scatter(1:200,mean(x),'k');
hold on;
plot([1 200],[5.73 5.73],'k');
plot([1 200],[4.27 4.27],'k');
hold off;