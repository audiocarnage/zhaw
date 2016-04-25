% Aufgabe 6.4 aus dem Script

x0 = 1;
f = @(x) sin(x);
fdiff = @(x) cos(x);

h = [0.1,0.05,0.05,0.0125];
D = @(h,x0) (f(x0+h)-f(x0))/h;

n = 3;
d = zeros(n);
for i=1:n+1
    d(i,1) = D(h/2^i,x0);
end

for i=2:n+1
    for k=1:n+1-i
        d(i,k) = ((2^(k)*D(i-1,k+1))-D(i-1,k))/(2^(k)-1);
    end
end