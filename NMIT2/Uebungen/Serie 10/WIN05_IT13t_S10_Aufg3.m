% NMIT2 - Serie 10, Aufgabe 3
% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Script

format compact; format short; clear all; clc;

t = 1900:10:2000;
p = [75.995 91.972 105.711 123.203 131.669 150.697 179.323 203.212 226.505 249.633 281.422];

yy = spline(t,p,2001)