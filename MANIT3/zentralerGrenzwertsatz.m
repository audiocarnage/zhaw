
format compact; format short; clear all; clc;

n = 120;
mu = 5
sigma = mu / sqrt(n)

X = exprnd(mu,n,200);
xm = mean(X);
%whos

standardabweichung = std(xm)

figure;
subplot(1,2,1), hist(xm);
grid on;
subplot(1,2,2), qqplot(xm);
grid on;