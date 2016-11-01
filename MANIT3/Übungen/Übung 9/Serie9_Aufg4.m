% MANIT3 - Serie 9, Aufgabe 4
% F(t) = P(T<=t)
% 1-F(t) = P(T>t)

format compact; format short; clear all; clc;

t = linspace(0,10);
c = 1/4;

F = @(t) 1-exp(-c.*t);
f = @(t) c.*exp(-c.*t);

figure;
plot(t,F(t),t,f(t));
xlabel('t');
ylabel('y');
grid on;
legend('Verteilungsfunktion F(t)','Dichtefunktion f(t)','location','best');

figure;
x = linspace(0,12,301);
F = expcdf(x,4);
f = exppdf(x,4);
plot(x,F,x,f);
grid on;
