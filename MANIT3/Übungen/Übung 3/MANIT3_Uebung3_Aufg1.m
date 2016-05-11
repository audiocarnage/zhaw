% MANIT3 - Übungsserie 3, Aufgabe 1

format compact
clc

x = [3 4 6 5 9 15];
y = [2 4 1 2 6 45];
x2 = [3 4 6 5 9];
y2 = [2 4 1 2 6];

figure;
plot(x,y,'bo','LineWidth',2.5);
lsline
xlabel('x');
ylabel('y');

hold on;
plot(x2,y2,'rx','LineWidth',1.5);
lsline
hold off;
