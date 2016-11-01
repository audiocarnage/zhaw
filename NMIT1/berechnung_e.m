% Script berecnung_e.m

format long;
tol = 1e-7;
e(1) = 1;
i = 2;
n = 2^i;
e(i) = (1+ (1/n))^n;
hold on;
while (abs(e(i) - e(i-1)) > tol)
    i = i + 1;
    n = 2^i;
    e(i) = (1 + (1/n))^n;
    plot(n,e(i),'ro','LineWidth',1.5);
end
e(i)
grid on;
title('Berechnung von e');
legend('f(n) = (1+1/n)^n','Location','northoutside');
xlabel('n');
ylabel('f(n)');
hold off;
