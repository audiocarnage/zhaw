% Script Georgiou_Remi_IT13t_S10_Aufg3b.m
% Testet die Laufzeit der Funktion Georgiou_Remi_IT13t_S10_Aufg3a
% Laufzeiten für ausgewählte Verfahren:
% Jacobi       :    9.326576 Sekunden
% Gauss-Seidel :    7.039622 Sekunden 
% Gauss-Verfahren : > 30 Minuten

AA = diag(diag(ones(3000)*4000))+ones(3000);
xx = [1:1:1500,1500:-1:1]';
bb = AA*xx;
xx0 = zeros(3000,1);
ttol = 1e-4;

tic;
[xn,n,n2] = Georgiou_Remi_IT13t_S10_Aufg3a(AA,bb,xx0,ttol,'jacobi');
toc
tic;
[xn,n,n2] = Georgiou_Remi_IT13t_S10_Aufg3a(AA,bb,xx0,ttol,'gs');
toc

%tic;
%[A_triangle,detA,x] = Georgiou_Remi_IT13t_S7_Aufg2(AA,bb);
%toc;