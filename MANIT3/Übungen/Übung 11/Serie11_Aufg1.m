% Serie 11, Aufgabe 1

format compact; format short; clear all; clc;

x = linspace(0,4);
f = @(x) x./8;
F = @(x) x.^2/16;

x1 = linspace(-4,0);
x2 = linspace(4,8);
f0 = @(x) 0.*x;
f4 = @(x) 0.*x;

figure;
subplot(1,2,1), cdfplot(x);

subplot(1,2,2), plot(x,f(x),'r',x,F(x),'b',...
    x1,f0(x1),'r',x2,f4(x2),'b','LineWidth',2);
xlabel('x');
ylabel('y');
xlim([-2 6]);
ylim([-0.5 1.5]);
legend('f(x)','F(x)','location','best');
grid on;

