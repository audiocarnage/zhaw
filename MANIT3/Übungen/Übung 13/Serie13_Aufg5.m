% MANIT3 - Serie 13, Aufgabe 5

format compact; format long; clear all; clc;

lambda = 3;
P = 1-poisscdf(3,lambda)

1-(poisscdf(3,lambda)^7)