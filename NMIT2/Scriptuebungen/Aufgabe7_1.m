% Script Aufgabe 7.1

clear all; format compact; format short; clc;

dydt = @(t,y) -1/2*y*t^2;

t = 0:3;
y = 0:3;

steigungen = [];
for i=1:length(t)
    for j=1:length(y)
        steigungen = [steigungen dydt(t(i),y(j))];
    end
end

for i=1:length(steigungen)
    fprintf('%d : %e\n', i, steigungen(i));
end
