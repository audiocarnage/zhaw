% MANIT3 - Serie 4, Aufgabe 2

format compact; format short; clear all; clc;

erschuetterung = [5.6 6.1 6 4.8 5.2 5.8 5.4 6 5.7 5.9 5.5 5.3 5.5 5.4 5.1 5 4.9 6.1 6]';
energie = [29 125 100 4 10 60 10 125 40 90 16 12 23 16 6 8 2 165 140]';

figure('name','MANIT3 - Serie 4, Aufgabe 2');
subplot(2,2,1);
plot(erschuetterung,energie,'ro');
title('Modell y=ax+b');
xlabel('Erschütterung');
ylabel('Energie');
grid on;

subplot(2,2,2);
plot(erschuetterung,log(energie),'go');
title('Modell log(y)=ax+b');
xlabel('Erschütterung');
ylabel('ln(Energie)');
lsline;
grid on;

N = length(erschuetterung);
X = [erschuetterung ones(N,1)];
[B,BINT,Residuen,RINT0,STATS] = regress(log(energie),X);

B

lnyhut = B(1).*erschuetterung + B(2);
yhut = exp(lnyhut);
[energie yhut]

subplot(2,2,3);
plot(erschuetterung,log(energie),'go',erschuetterung,log(yhut),'ro');
title('y vs. yhut');
xlabel('Erschütterung');
ylabel('Energie');
grid on;

% Residuenplot
subplot(2,2,4);
plot(log(yhut),Residuen,'bo');
title('Residuenplot');
xlabel('y hut');
ylabel('Residuen');
grid on;
lsline;

R2 = var(yhut)/var(energie)

ER = @(x) B(2)*x + B(1);
ER(5.7)