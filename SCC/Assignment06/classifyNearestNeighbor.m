% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: October 2016
% 
% Returns a vector alpha with alpha(i) denoting the class asisgned to the 
% point of the i-th row of matrix M according to the Gaussian mixture model.
% 
% input: A, a matrix whose rows can be partitioned into k equally sized
%           sets of points belonging to the same class
%        M, a matrix 
%        k, an integer denoting the number of classes
% return: alpha, the distance
% Example: [alpha] = classifyNearestNeighbor(A1, M1, 3)

function [alpha] = classifyNearestNeighbor(A, M, k)

d = size(A,2);
N = size(A,1)/k;

% means matrix stores the mean of each class
means = zeros(k, d);

% stores the probability density value for each point p
probDensity = zeros(size(M, 1), k);

% T: subset of rows of A belonging to class i
for i=1:k
    T = A((i-1)*N+1:N*i, :);
    for j=1:d
        means(i,j) = mean(T(:, j));
    end
    covMatrix = cov(T);
    probDensity(:,i) = mvnpdf(M, means(i,:), covMatrix);
end

for i=1:size(M,1)
    [m, alpha(i)] = max(probDensity(i,:));
end

end