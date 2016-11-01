% Regression mit mehreren Variablen

format short; format compact; clear all; clc;

preis = [28500 31500 28900 29500 24500 25500 38800 25400 23900 29800 22500];
jahrgang = [1996 1998 1998 1996 1998 1997 1998 1995 1996 1998 1995];
km = [28100 28200 28000 36200 41300 36600 22550 66000 92000 16000 84000];

A = [jahrgang' km' ones(length(preis),1)];

% Lösen des linearen Gleichungssystems
A'*A
x = inv(A'*A)*A'*preis'

[B,BINT,R,RINT,STATS] = regress(preis',A);

% yhut = preishut
yhut = A*x

B

f = @(jahr,km) B(1)*jahr + B(2)*km + B(3);
preise = ((jahrgang.*B(1)) + (km.*B(2)) + B(3))';

% erklärte Preise
preishut = A*B;
[preis' preishut yhut]

R2 = var(yhut)/var(preis)
residuen = preis' - yhut

myCar = f(2011,50000)

figure('name','Regression mit mehreren Variablen');
plot(preishut,R,'bo','MarkerSize',7);
xlabel('Preis hut');
ylabel('Residuen');
lsline;
