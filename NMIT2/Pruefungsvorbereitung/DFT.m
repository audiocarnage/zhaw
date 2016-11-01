% berechnet die diskrete Fourier-Transformation
% vorausgesetzt der Abstand zwischen den punkten t sei äquidistant
% Beispiel: 

function[kp,Ak,Bk] = DFT(t,f)
    
if (length(t) ~= length(f))
   error('Dimensions must agree.') 
end

n = floor(length(f)/2);
T = t(2*n)-t(1);
omega = 2*pi/T;

Ak = zeros(1,n+1);
Bk = zeros(1,n+1);
kp = 0:n;

% A0
Ak(1) = sum(f(1:2*n)) / (2*n);
% An
for i=1:2*n
    Ak(n+1) = Ak(n+1) + (f(i) * cos(n*omega*t(i)));
end
Ak(n+1) = Ak(n+1) / (2*n);

for k=2:n
    Ak(k) = 0;
    Bk(k) = 0;
    for i=1:2*n
        Ak(k) = Ak(k) + (f(i) * cos((k-1)*omega*t(i)));
        Bk(k) = Bk(k) + (f(i) * sin((k-1)*omega*t(i)));
    end
    Ak(k) = Ak(k) / n;
    Bk(k) = Bk(k) / n;
end

end