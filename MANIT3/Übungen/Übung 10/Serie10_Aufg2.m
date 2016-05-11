% Serie 10, Aufgabe 2

format compact; format short; clear all; clc;

p = 1-0.05;
n = 74;

figure();
x = 0:n;
y = binocdf(x,n,p,'upper') ;
bar(x,y,0.5);
grid on;
y(73)
