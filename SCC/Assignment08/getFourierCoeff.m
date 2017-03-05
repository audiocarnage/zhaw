
function [A0,A,B] = getFourierCoeff(f,a,b,n)

T = b-a;
A0 = 1/(2*T) * integral(f,a,b);

A = zeros(1,n);
B = zeros(1,n);
syms x

for i=n
    A(i) = 1/(T/2) * integral(matlabFunction(f * cos(n*x)),a,b);
    B(i) = 1/(T/2) * integral(matlabFunction(f * sin(n*x)),a,b);
end

end