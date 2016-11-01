% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Beispiel: [x,y_euler,y_mittelpunkt,y_modeuler] = WIN05_IT13t_S5_Aufg3(@(x,y) x.^(2)./y,0,2.1,3,1.5)

function [x,y_euler,y_mittelpunkt,y_modeuler] = WIN05_IT13t_S5_Aufg3(f,a,b,n,y0)

%format compact; format shortE; clc;

h = (b-a)/n;
%[X,Y] = meshgrid(a:h/2:b, y0:h/2:(y0*2));

% Klassischer Eulerverfahren
x(1) = a;
y_euler(1) = y0;
for i=1:n
    x(i+1) = x(i) + h;
    y_euler(i+1) = y_euler(i) + (h*f(x(i),y_euler(i)));
end
clear x;

% Mittelpunktverfahren
x(1) = a;
y_mittelpunkt(1) = y0;
for i=1:n
    xmitte = x(i) + (h/2);
    ymitte = y_mittelpunkt(i) + (h/2*f(x(i),y_mittelpunkt(i)));
    x(i+1) = x(i) + h;
    y_mittelpunkt(i+1) = y_mittelpunkt(i) + (h*f(xmitte,ymitte));
end
clear x;

% Modifiziertes Eulerverfahren
x(1) = a;
y_modeuler(1) = y0;
for i=1:n
    x(i+1) = x(i) + h;
    yeuler = y_modeuler(i) + (h*f(x(i),y_modeuler(i)));
    k1 = f(x(i),y_modeuler(i));
    k2 = f(x(i+1),yeuler);
    x(i+1) = x(i) + h;
    y_modeuler(i+1) = y_modeuler(i) + (h*(k1+k2)/2);
end

%figure('name','MANIT3 - Serie 5, Aufgabe 3');
%plot(x,y_euler,'b-.o','LineWidth',1.5,'MarkerSize',6,'MarkerEdgeColor','y');
%title('');
%hold on;
%plot(x,y_mittelpunkt,'k--o','LineWidth',1.5,'MarkerSize',6,'MarkerEdgeColor','y');
%plot(x,y_modeuler,'r-o','LineWidth',1.5,'MarkerSize',6,'MarkerEdgeColor','y');
%WIN05_IT13t_S5_Aufg1(f, a, b, a, b, h, h);
%xlim auto;
%ylim auto;
%xlabel('x');
%ylabel('y');
%legend('Klassisches Eulerverfahren','Mittelpunktverfahren',...
%    'Modifiziertes Eulerverfahren','Richtungsfeld der DGL','Location','NW');
%grid on;
%hold off;

end