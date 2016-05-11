% Varianzanalyse

format compact; format short; clear all; clc;

x=[3 5 6 10]';
y=[5 4 8 11]';

N=length(x);

X = [ones(N,1) x]

[b,bint,residuen,rint,stats] = regress(y,X)

figure;
subplot(1,2,1);
plot(x,y,'ro','LineWidth',3);
lsline

yhut = X*b
mean(yhut)
y-yhut

syhutyhut = sum(yhut.^2)-N*mean(yhut)^2
see = sum(residuen.^2)-N*mean(residuen)^2

syy = syhutyhut + see

RQuadrat = var(yhut)/var(y)

r = sqrt(RQuadrat)
cov(x,y)

subplot(1,2,2);
plot(x,residuen,'ro','LineWidth',3);
lsline
