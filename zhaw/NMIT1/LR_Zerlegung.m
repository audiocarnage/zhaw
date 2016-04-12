% Script LR-Zerlegung

A = [-1 1 1;1 -3 -2;5 1 4]
b = [1;0;-2]

[L,U,P] = lu(A, 'vector')
optsL.LT = true;
optsR.UT = true;
b_perm = b(P)
y = linsolve(L, b_perm, optsL)
x = linsolve(U, y, optsR)