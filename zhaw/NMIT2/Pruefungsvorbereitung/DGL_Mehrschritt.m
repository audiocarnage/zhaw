% DGL 1. Ordnung lösen mit Mehrschrittverfahren

format compact; format long; clear all; clc;

% Paramter
a = 0;
b = 1;
f = @(x,y) y;
%n = 10
h = 0.1;
y0 = 1;
n = (b-a)/h;


[x_ab2,y_ab2] = AdamsBashforth2(f,a,b,n,y0);
[x_ab3,y_ab3] = AdamsBashforth3(f,a,b,n,y0);
[x_ab4,y_ab4] = AdamsBashforth4(f,a,b,n,y0);
[x_ab5,y_ab5] = AdamsBashforth5(f,a,b,n,y0);

figure;
plot(x_ab2,y_ab2,x_ab3,y_ab3,x_ab4,y_ab4,x_ab5,y_ab5);
hold on;   
Richtungsfeld(f,x_ab5,y_ab5);
hold off;
legend('Adams-Bashforth 2','Adams-Bashforth 3','Adams-Bashforth 4',...
    'Adams-Bashforth 5','Richtungsfeld','location','best');
