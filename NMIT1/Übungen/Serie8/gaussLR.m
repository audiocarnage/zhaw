% Funktion Georgiou_Remi_IT13t_S7_Aufg2
% Implementierung der Gauss-Elimination zur L�sung von linearen
% Gleichungssystemen, zus�tzlich mit einer LR-Zerlegung
% Parameter: Matrix A, Vektor b
% R�ckgabewerte: untere normierte Dreiecksmatrix L, obere Dreiecksmatrix R,
% Permutationsmatrix P, Determinante von R, Vektor x
% Beispiel eines Funktionsaufrufes:
% [L,R,P,detA,x] = gaussLR([20 10 0;50 30 20;200 150 100],[150;470;2150])

function[L,R,P,detA,x] = gaussLR(A,b)

% m Zeilen, n Spalten
[m,n] = size(A);
% Datenvektor
[p,q] = size(b);
P = eye(m,n);
L = P;

assert(m == p, 'Dimensions don''t match.');

% erweiterte Koeffizientenmatrix
M = [A b];
epsilon = 1e-16;

% �ber alle Zeilen der erweiterten Koeffizientenmatrix M
for i=1:p
    % finde Pivot-Zeile
    pivotzeile = i;
    pivotPermut = i;
    
    for a=i+1:p
        if abs(M(a,i)) > abs(M(pivotzeile,i))
           pivotzeile = a;
           pivotPermut = a;
        end 
    end
    
    % swap
    tempRow = M(i,:);
    M(i,:) = M(pivotzeile,:);
    M(pivotzeile,:) = tempRow;
    
    tempPermut = P(i,:);
    P(i,:) = P(pivotPermut,:);
    P(pivotPermut,:) = tempPermut;
    
    % singul�re oder fast singul�re Matrix?
    assert(abs(M(i,i)) >= epsilon, 'Matrix is singul�r. Das Gleichungssystem ist nicht eindeutig l�sbar');
    
    % f�r alle Spalten > i
    for j=i+1:p
        lambda = M(j,i) / M(i,i)
        % einzelne Zeilenelemente eliminieren
        for k=i:p+1
            M(j,k) = M(j,k) - (lambda * M(i,k));
        end
        % Zum Testen: Ausgabe der Dreiecksmatrix nach jeder Zeilenoperation
        M;
        L(j,i) = lambda;
    end
end
A_triangle = M(1:m,1:n);
R = A_triangle;

% Determinante von A_triangle berechnen
detA = 1;
for i=1:length(A_triangle)
    detA = detA * A_triangle(i,i);
end

% R�ckw�rts einsetzen
x = zeros(p,q);
for i=p:-1:1
    summe = 0;
    for j=i:p
        summe = summe + (M(i,j)* x(j));
    end
    x(i) = (M(i,n+1)-summe) / M(i,i);
end

end