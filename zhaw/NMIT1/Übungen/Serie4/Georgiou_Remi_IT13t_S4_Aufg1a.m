% Skript Georgiou_Remi_IT13t_S4_Aufg1b
% Termumformung:
% ((10.^(2*x))/(2.^(5*x))).^2 = 5.^(4*x) * 2.^(-6*x)

x = logspace(0,2);

f = log10(5 * (2*x.^2).^(-1/3));
g = log(1e5*(2*exp(1)).^(-x./100));
h = log10(5.^(4*x) / 2.^(6*x));

figure('Name','Serie 4 - Aufgabe 1,a)');
subplot(1,3,1);
semilogx(x,f);
xlabel('x');
ylabel('f(x)');
legend('f(x) = 5 * (2x^2)^{-1/3}','Location','northoutside');

subplot(1,3,2);
plot(x,g);
xlabel('x');
ylabel('f(x)');
legend('f(x) = 10^5 * (2e)^{-x/100}','Location','northoutside');

subplot(1,3,3);
semilogx(x,h,'-*r');
xlabel('x');
ylabel('f(x)');
legend('f(x) = 5^{4x} * 2^{-6x}','Location','northoutside');