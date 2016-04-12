% SEP NMIT2, Aufgabe 2

format compact; format long; clear all; clc;

x0 = 0.7;
y0 = 0.5;

% a)
% bei nichtlinearen Ausgleichsproblemen
% beim numerischen Lösen nichtlinearer Gleichungssysteme

% c)
% Vorwärtsdifferenz
u = @(x,y) 2.*cos(x) + cos(y);
v = @(x,y) cos(x) + 2.*sin(y);
g = @(x,y) [f1(x,y); f2(x,y)];

h = 0.1;
D1f_eval_u = (u(x0+h,y0) - u(x0,y0)) / h
D1f_eval_v = (v(x0+h,y0) - v(x0,y0)) / h

