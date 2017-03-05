% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Dezember 2016
%
% Numerical solution of the Initial Value Boundary Problem 
% for the Heat Transfer Equation in 1D
%
% input: xrange, a vector of length n with equally spaced values x1...xn
%        trange, a vector of length m with equally spaced values t1...tm
%        u_initial, a vector of length n with initial conditions
%                   f(x1)...f(xn)
%        u0_boundary, a vector of length m with the boundary conditions
%                     u0(t1)...u0(tm)
%        uL_boundary, a vector of length m with the boundary conditions
%                     uL(t1)...uL(tm)
%        k, constant from the heat equation
% return: u, the numerical solution u(x,t) = u of the IVBP
%             a matrix of size (n x m)

function [u] = Heat_Transfer_Equation(xrange,trange,u_initial,u0_boundary,uL_boundary,k)

n = length(xrange);
m = length(trange);
dx = (xrange(n)-xrange(1)) / (n-1);
dt = (trange(m)-trange(1)) / (m-1);
alpha = k*dt/(dx^2);
% stepsize should be adjusted so that alpha < 0.5
assert(alpha < 0.5);

u = zeros(n,m);
u(:,1) = u_initial;
u(1,:) = u0_boundary;
u(end,:) = uL_boundary;

for j=1:m-1
   for i=2:n-1
       u(i,j+1) = u(i,j) + (alpha*(u(i+1,j) - 2*u(i,j) + u(i-1,j)));
   end
end

end