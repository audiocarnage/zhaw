% Varianz-Zerlegung und Bestimmtheitsmass

format compact; format short; clear all; clc;

x = [3 5 6 10]';
y = [5 4 8 11]';

X = [x ones(4,1)];
[b,bint,r,rint,stats] = regress(y,X)
b

yhut = X*b
