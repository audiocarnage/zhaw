
format compact; format short; clear all; clc;

x = [5 7 5 5 8 2 10];
y = [6 4 7 4 3 7 1];

sumx = x*x'
sumy = y*y'
sx = var(x)
sy = var(y)
mittelwertx = mean(x)
mittelwerty = mean(y)
kovarianz = cov(x,y)
cov(x)
cov(y)
