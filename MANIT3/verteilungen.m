format compact; format short; clear all; clc;

%%

X = 0:3;
P = [0.125 0.375 0.375 0.125];
figure;
bar(X,P,0.05);
title('Stabdiagramm');
xlabel('x');
ylabel('p');
grid on;

%%

figure;

x = linspace(0,15,301);
f5 = chi2pdf(x,5);
f10 = chi2pdf(x,10);
plot(x,f5,x,f10);
chi2inv(0.99,5)

x = [0:5]';
pd = hygepdf(x,12,4,5);
pc = hygecdf(x,12,4,5);
[x  pd pc]
bar(x,pd);
bar(x,pd,0.2);
stairs(x,pc);

%hygeinv
