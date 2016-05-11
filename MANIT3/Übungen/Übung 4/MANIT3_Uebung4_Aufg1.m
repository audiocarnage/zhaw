% MANIT3 - Serie 4, Aufgabe 1

format short; format compact; clear all; clc;

s = [8 10 6 14 18 27 30 25 36 60 55 50 80 90 85 110 102 100 160 140 210 190]';
v = [20 20 20 30 30 50 50 50 60 80 80 80 100 100 100 120 120 120 150 150 180 180]';

figure('name','MANIT3 - Serie 4, Aufgabe 1');
subplot(2,2,1);
plot(v,s,'ro','MarkerSize',6);
title('Modell av+b');
xlabel('v [m/s]');
ylabel('s [m]');
grid on;

N = length(v);
X = [v ones(N,1)];
[B,BINT,Residuen,RINT0,STATS] = regress(s,X);
a = B(1)
b = B(2)
shut = X*B;
RQ = STATS(1)

subplot(2,2,2);
plot(v,Residuen,'bo','MarkerSize',6);
title('Residuen');
xlabel('v [m/s]');
ylabel('e');
lsline
grid on;

z = s./v;
subplot(2,2,3);
plot(v,z,'go','MarkerSize',6);
title('Modell z = s/v = av+b');
xlabel('v [m/s]');
ylabel('z [m]');
lsline
grid on;

N = length(v);
X = [v ones(N,1)];
[B,BINT,Residuen,RINT0,STATS] = regress(z,X);
a = B(1)
b = B(2)
zhut = X*B;
RQ = STATS(1)

subplot(2,2,4);
plot(v,Residuen,'bo','MarkerSize',6);
title('Residuen');
xlabel('v [m/s]');
ylabel('e');
lsline
grid on;
