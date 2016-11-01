% Serie 10, Aufgabe 3

format compact; format short; clear all; clc;

p = 1/3;
n = 15;
n60 = 15 * 0.6;

% a)
figure();
x = 0:n;
y = binocdf(x,n,p,'upper');
bar(x,y,0.5);
grid on;
disp('a)')
fprintf('P(X=%d) = %1.5f\n\n', n60, y(n60))

% b)
disp('b)')
px = 1e-3;

for i=n60:n
    if (y(i) < px)
       fprintf('i = %d\n',i)
       fprintf('%1.10f\n', y(i))
       break;
    end
end