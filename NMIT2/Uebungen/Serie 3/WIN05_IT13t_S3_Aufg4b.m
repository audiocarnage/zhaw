% NMIT2 - Serie 3, Aufgabe 4, b)
% @author Georgiou Rémi (georgrem), Stocker André (stockan1)
% Erdmasse F gemäss http://solarsystem.nasa.gov/planets/earth/facts

clc; clear all; format long; format compact;

a = 0; b = 6370;
r = 10^3 * [0 800 1200 1400 2000 3000 3400 3600 4000 5000 5500 6370];
p = [13000 12900 12700 12000 11650 10600 9900 5500 5300 4750 4500 3300];
f = @(r,p) p.*4.*pi.*(r.^2);
F = 5.9722 * 10^24 	
y = f(r,p)

Tf_neq = WIN05_IT13t_S3_Aufg4a(r, y)
E_abs = abs(F - Tf_neq)
E_rel = E_abs / F