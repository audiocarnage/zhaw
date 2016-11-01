% Script Georgiou_Remi_IT13t_S7_Aufg3
% Resultate der Funktion Georgiou_Remi_IT13t_S7_Aufg2 mit dem MATLAB
% \-Operator überprüfen.
% Input sind Gleichugsysteme aus Aufgabe 4.3 aus dem Vorlesungsskript auf 
% Seite 48.
% Bis auf Rundungsfehler stimmen die Resultate für x überein.

% INPUT
A1 = [4 -1 -5;-12 4 17;32 -10 -41];
b1 = [-5;19;-39];
A2 = [2 7 3;-4 -10 0;12 34 9];
b2 = [25;-24;107];
A3 = [-2 5 4;-14 38 22;6 -9 -27];
b3 = [1;40;75];
A4 = [-1 2 3 2 5 4 3 -1; ...
       3 4 2 1 0 2 3 8; ...
       2 7 5 -1 2 1 3 5; ...
       3 1 2 6 -3 7 2 -2; ...
       5 2 0 8 7 6 1 3; ...
       -1 3 2 3 5 3 1 4; ...
       8 7 3 6 4 9 7 9; ...
       -3 14 -2 1 0 -2 10 5];
b4 = [-11;103;53;-20;95;78;131;-26];

% OUTPUT
[A_triangle,det,x] = Georgiou_Remi_IT13t_S7_Aufg2(A1, b1)
y = A1\b1
tf = isequal(x,y)
[A_triangle,det,x] = Georgiou_Remi_IT13t_S7_Aufg2(A2, b2)
y = A2\b2
tf = isequal(x,y)
[A_triangle,det,x] = Georgiou_Remi_IT13t_S7_Aufg2(A3, b3)
y = A3\b3
tf = isequal(x,y)
[A_triangle,det,x] = Georgiou_Remi_IT13t_S7_Aufg2(A4, b4)
y = A4\b4
tf = isequal(x,y)