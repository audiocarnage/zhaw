% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 7, Aufgabe 1
% Adams-Bashforth Koeffzienten

clc; format rat; clear all; format compact;

s = 3; j = 0:s; syms u;
factor = ((-1).^j)./(factorial(j).*factorial(s-j));
p(1) = (u + 1)*(u + 2)*(u + 3);
p(2) = (u + 0)*(u + 2)*(u + 3);
p(3) = (u + 0)*(u + 1)*(u + 3);
p(4) = (u + 0)*(u + 1)*(u + 2);

for i=1:s+1
    integ = WIN05_IT13t_S3_Aufg3(matlabFunction(p(i)),0,1,1);
    b = factor(i) * integ
end