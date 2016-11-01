% MANIT3 - Serie 3, Aufgabe 6

format short; format compact; clear all; clc;

jahr = [1880 1888 1900 1920 1930 1950 1960 1980]';
bewohner = [2846 2918 3315 3880 4066 4715 5429 6366]';

N = length(jahr);
X = [jahr ones(N,1)];
lnbewohner = log(bewohner);
[b,bint,residuen,rint,stats] = regress(lnbewohner,X);
b
f = @(x) exp(b(1).*x + b(2));

jahr(N+1) = 2000;
jahr(N+2) = 2015;
jahr(N+3) = 2030;
bewohner(N+1) = f(2000);
bewohner(N+2) = f(2015);
bewohner(N+3) = f(2030)

figure('name','MANIT3 - Serie 3, Aufgabe 6');
subplot(1,3,1);
plot(jahr,bewohner,jahr,f(jahr));
xlabel('Jahr');
ylabel('Bewohner (in 1000)');
legend('Datenpunkte','Berechnet','location','best');
grid on;
