% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% Implementierung des Algorithmus zur Berechnung der natürlichen kubischen
% Splinefunktion S(x)
% Beispiel: [yy,a,b,c,d] = cubicSpline([0 1 2 3],[2 1 2 2],1:3)

function[yy,a,b,c,d] = cubicSpline(x,y,xx)

    format compact; format short; clc;
    
    if (length(x) ~= length(y))
        error('Dimensions must agree.')
    end
	
    n = length(x)-1;
    nxx = length(xx);
    
	% Schrittweiten
	h = x(2:n+1) - x(1:n);
	
    % Koeffizienten a
    a = y(1:n+1);
    
    % Koeffizienten c
    c(1) = 0;
    c(n+1) = 0;
    
	diagonale = 2*(h(1:n-1)+h(2:n));
	seitendiagonale = h(2:n-1);
	A = diag(diagonale) + diag(seitendiagonale,-1) + diag(seitendiagonale,1);
	zspalte = (y(2:n+1) - y(1:n))./h;
	z = (3*(zspalte(2:n) - zspalte(1:n-1)))';
	% Lineares Gleichungssystem lösen
	c(2:n) = A\z;
	
	% Koeffizienten b
	b = ((y(2:n+1) - y(1:n))./h) - ((h./3).* (c(2:n+1) + (2*c(1:n))));
	
	% Koeffizienten d
	d = (1./(h.*3)).* (c(2:n+1) - c(1:n));
	
	% kubisches Polynom S(x)
	syms xi;
	S = @(xi,i) a(i) + (b(i).*(xi-x(i))) + (c(i).*(xi-x(i)).^2) + (d(i).*(xi-x(i)).^3);
	  
    yy=[];
    
    for i=1:n
       Si(i) = S(xi,i);
       for j=1:nxx
          if (x(i)<=xx(j) & xx(j)<=x(i+1))
              Sif = matlabFunction(Si(i));
              yy(j) = Sif(xx(j));
          end
       end
    end
    
    pretty(Si)    
end