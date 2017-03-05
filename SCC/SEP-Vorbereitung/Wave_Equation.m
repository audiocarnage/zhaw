% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, Dezember 2016
%
% Numerical solution of the Initial Value Boundary Problem 
% for the Wave Equation in 1D
%
% input: xrange, a vector of length n with equally spaced values x1...xn
%        trange, a vector of length m with equally spaced values t1...tm
%        u_initial, a vector of length n with initial conditions
%                   f(x1)...f(xn)
%        du_initial, a vector of length n with initial conditions
%                    g(x1)...g(xn)
%        u0_boundary, a vector of length m with the boundary conditions
%                     u0(t1)...u0(tm)
%        uL_boundary, a vector of length m with the boundary conditions
%                     uL(t1)...uL(tm)
%        c, constant velocity from the wave equation
% return: u, the numerical solution u(x,t) = u of the IVBP
%             a matrix of size (n x m)

function [u] = Wave_Equation(xrange,trange,u_initial,du_initial,u0_boundary,uL_boundary,c)

n = length(xrange);
m = length(trange);
dx = (xrange(n)-xrange(1)) / (n-1);
dt = (trange(m)-trange(1)) / (m-1);
alpha = c*dt/dx;
% stepsize should be adjusted so that alpha^2 < 1.0
assert(alpha^2 < 1.0);

u = zeros(n,m);
u(:,1) = u_initial;
u(:,2) = du_initial;
u(1,:) = u0_boundary;
u(end,:) = uL_boundary;

for j=2:m-1
   for i=2:n-1
       if (j==2)
          u(i,j) = ((alpha^2)/2 * (u(i-1,1) + u(i+1,1))) + ((1-(alpha^2)) * (u(i,1))) + (dt * du_initial(i));
       end
       u(i,j+1) = (alpha^2 * (u(i-1,j) + u(i+1,j))) + (2*(1-(alpha^2))*u(i,j)) - u(i,j-1);
   end
end

end