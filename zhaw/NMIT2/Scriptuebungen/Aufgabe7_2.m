% Script Aufgabe 7.2

clear all; format compact; format shortE; clc;

N = 5;
a = -1.5;
b = 1.5;
h = (b-a)/N;

[X,Y] = meshgrid(a:h:b, 0:h:4);

y(1) = 0;
dydt = @(t,yi) t.^(2) + (yi.*0.1);
ydiff = dydt(X,Y);

xi(1) = a;
for i=2:N+1
    xi(i) = xi(i-1) + h;
    y(i) = y(i-1)+(h*dydt(xi(i-1),y(i-1)))
end

figure('name','Scrip Aufgabe 7.2');
%subplot(1,2,1);
plot(xi,y,'r--s','LineWidth',1,'MarkerSize',6,'MarkerEdgeColor',[0.1,0.72,0.3]);
xlabel('xi');
ylabel('y');
grid on;
hold on;
%subplot(1,2,2);
quiver(X,Y,ones(size(X)),ydiff);
