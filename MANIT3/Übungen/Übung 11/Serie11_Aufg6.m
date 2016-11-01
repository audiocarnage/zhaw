% Serie 11, Aufgabe 6
% Eine Stromsparbirne habe die erwartete Lebensdauer von 2000h. Man nimmt an, dass die
% Brenndauer exponentiell verteilt sei. Bestimme die Kennwerte von 12 Birnen, wenn man sie
% hintereinander einsetzt.

format compact; format short; clear all; clc;

syms c t
f(c,t) = 1/c * exp(-c.*t);
mu_x = 2000 % [h]
c = 1/mu_x
varianz_x = 1/c^(2)
std_x = sqrt(varianz_x)

numberOfLightBulbs = 12;
t = linspace(0,2000);
y = f(c,t);

bar(y);
xlabel('t [h]');

mu_s = numberOfLightBulbs * mu_x
std_s = sqrt(numberOfLightBulbs) * std_x