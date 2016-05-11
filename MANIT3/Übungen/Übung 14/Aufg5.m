% MANIT3 - Serie 14, Aufgabe 5

% Ein Schiessbudenbesitzer muss pro Abend im Mittel etwa 20 erste Preise aushändigen. Wie viele soll
% er vorrätig haben, damit er nur mit Wahrscheinlichkeit 2% in Verlegenheit kommt?

format compact; format short; clear all; clc;

% Annahme: die Verteilung ist Poisson-verteilt
% lambda = mu

lambda = 20

1-poisscdf(29,lambda)
