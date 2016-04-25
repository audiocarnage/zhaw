% Funktion Georgiou_Remi_IT13t_S3_Aufg3(x,B,nmax)
% x: reelle Zahl im Zehnersystem
% B: Umrechnung in die Basis B, wobei 1 < B < 10
% nmax: Anzahl Nachkommastellen
% Die Funktion hat 4 Rückgabewerte : y,value,abs_error,rel_error
% y ist die Zahl x umgewandelt in die Basis B mit nmax Nachkommastellen
% value ist der Wert von y im Dezimalsystem, d.h. der Näherungswert von x
% abs_err ist der absolute Fehler, rel_err der relative Fehler der beim 
% Abschneiden auftritt
% Beispiel eines Funktionsaufrufes:
% [y,value,abs_err,rel_err] = Georgiou_Remi_IT13t_S3_Aufg3(56.78,6,12)

function[y,value,abs_err,rel_err] = Georgiou_Remi_IT13t_S3_Aufg3(x,B,nmax)

if B < 2 || B > 9,
    error('Ungülite Eingabe für Parameter ''Basis''. 1 < B < 10');
end

format long;
integer = abs(fix(x));
fraction = abs(x)-integer;

% Umwandlung des ganzzahligen Teil von x in die Basis B.
% Das Vorzeichen wird für die Umwandlung ignoriert, es wird bei der
% Rückgabe von y und value wieder berücksichtigt.
intY = [];
while (integer > 0)
    intY = [intY num2str(mod(integer,B))];
    integer = fix(integer/B);
end
intY = flip(intY);

% Umwandlung der Nachkommastellen von x in die Basis B.
% Gleichzeitig werden die Nachkommastellen von value mittels 
% Hornerschema berechnet. 
% Die Genauigkeit wird mit dem Parameter nmax definiert.
fractionY = [];
valueFraction = 0;
if fraction > 0,
    for p=1:1:nmax
        fractionY = [fractionY num2str(fix(fraction*B))];
        fraction = (fraction*B) - fix(fraction*B);
        coeff = str2num(fractionY(p));
        valueFraction = valueFraction + (coeff * B.^(-p));
    end
end

vorzeichen = '+';
if sign(x)== -1, vorzeichen = '-'; end;
y = strcat(vorzeichen,intY,'.',num2str(fractionY));

format shortE;
value = sign(x) * (abs(fix(x)) + valueFraction);
abs_err = abs(value - x);
rel_err = abs((value - x) / x);
end