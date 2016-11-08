% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: October 2016
% 
% Returns a vector alpha with alpha(i) denoting the class asisgned to the 
% point of the i-th row of matrix M according to the nearest mean strategy.
% 
% input: A, a matrix whose rows can be partitioned into k equally sized
%           sets of points belonging to the same class
%        M, a matrix 
%        k, an integer denoting the number of classes
% return: alpha, the distance
% Example: [alpha] = classifyNearestMean(A1, M1, 3)

function [alpha] = classifyNearestMean(A, M, k)

d = size(A,2);
N = size(A,1)/k;

% means matrix stores the mean of each class
means = zeros(k, d);

% T: subset of rows of A belonging to class i
for i=1:k
    T = A((i-1)*N+1:N*i, :);
    for j=1:d
        means(i,j) = mean(T(:, j));
    end
end

distanceToMean = zeros(k,1);

for i=1:size(M,1)
    for j=1:k
        distanceToMean(j) = distance(M(i,:)', means(j,:)');
    end
    [m, alpha(i)] = min(distanceToMean);
end

end