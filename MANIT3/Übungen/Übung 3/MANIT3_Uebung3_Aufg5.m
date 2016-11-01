% MANIT3 - Serie 3, Aufgabe 5

format short; format compact; clc;

x = [2 6 8 12 12 4 7]';
y = [5 20 48 260 220 10 38]';

figure('name','MANIT3 - Serie 3, Aufgabe 5');
subplot(1,3,1);
plot(x,y,'go','LineWidth',2,'MarkerSize',8);
xlabel('x');
ylabel('y');
grid on;

lny = log(y)
subplot(1,3,2);
plot(x,lny,'go','LineWidth',2,'MarkerSize',8);
xlabel('x');
ylabel('ln(y)');
lsline;
grid on;

X = [ones(7,1) x];

[b,bint,residuen,rint,stats] = regress(lny,X);

subplot(1,3,2);
plot(x,lny,'go','LineWidth',2,'MarkerSize',8);
lsline
xlabel('x');
ylabel('ln(y)');
grid on;

lnyhut = X*b

yhut = exp(lnyhut)
mean(yhut)
y-yhut

[y yhut]

subplot(1,3,3);
plot(x,y,'bo','LineWidth',2,'MarkerSize',8);
hold on;
plot(x,yhut,'r*','LineWidth',2,'MarkerSize',8);
hold off;
xlabel('x');
ylabel('y');
grid on;
