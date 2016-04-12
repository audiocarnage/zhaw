% Script Jacobi-Verfahren

A = [8 5 2;5 9 1;4 2 9];
b = [19;5;34];
x0 = [1;-1;3];

L = tril(A,-1);
R = triu(A,1);
D = diag(diag(A,0));
B = -(inv(D)) * (L+R);

if norm(B,inf) < 1
    'konvergiert'
else
    'konvergiert nicht'
end

% Variante für Konvergenzkriterium
% Prüfen auf Diagonaldominanz
[m,n]=size(A);
diagonaldominant = true;
for i=1:m
    s = sum(A,2);
    if diagonaldominant && A(i,i) > (s(i)-A(i,i))
        diagonaldominant = true;
    else
        diagonaldominant = false;
    end
end

if diagonaldominant
    'konvergiert'
else
    'konvergiert nicht'
end

% auf Fixpunktform bringen (L+R+D)x=b
x = (L+R+D)\b;

xold = x0;
for n=1:4
    xnew = (B*xold) + b;
    xold = xnew;
end
xnew

% à-postériori-Abschätzung