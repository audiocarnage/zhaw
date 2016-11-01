% Serie 12, Aufgabe 6
% S195 ~ N(195*mu,sqrt(195)*sigma)

format compact; format short; clear all; clc;

n = 200;

mu = 10
sigma = 2
varianz = sigma^2;

% gesucht: P(S195 >= 2000)
1-normcdf(2000,195*mu,sqrt(195)*sigma)
