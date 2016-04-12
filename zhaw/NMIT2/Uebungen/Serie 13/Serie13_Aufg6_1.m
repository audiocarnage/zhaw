% NMIT2 - Serie 13, Aufgabe 6.1

format compact; format longE; clear all; clc;

%f = @(x) log10(x) + exp(-sin(3*x) + x^2);
f = @(x) sin(x);
syms x
fdiff = matlabFunction(diff(f,x));
f2diff = matlabFunction(diff(f,x,2));

x0 = 1;
hi = [1e-2 1e-4 1e-6 1e-8 1e-10 1e-15 1e-16];
n = length(hi);

h_opt = sqrt(4*eps* (abs(f(x0)) / abs(f2diff(x0))))

% Vorwärtsdifferenz
D1f = @(x0,h) (f(x0+h)-f(x0)) / h;

y = zeros(1,n);
diskret_fehler = zeros(1,n);

fprintf('h \t\t\t\t D1f(1,h) \t\t |D1f(1,h)-f''(x0)| \n')

for i=1:n
    y(i) = D1f(x0,hi(i));
    diskret_fehler(i) = abs(y(i) - fdiff(x0));
    fprintf('%e \t %e \t %e \n',hi(i),y(i),diskret_fehler(i))
end

figure;
subplot(1,2,1);
loglog(hi,y);
xlabel('Schrittweite h');
ylabel('y');
grid on;
legend(func2str(f),'location','best');

subplot(1,2,2);
loglog(hi,diskret_fehler,'r');
xlabel('Schrittweite h');
ylabel('Diskretisierungsfehler');
grid on;
