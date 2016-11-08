% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
%
% Generic function for ploting N clusters.
%
% input: X, a single cluster of dataset
%        alpha, the cluster-indices vector

function [] = plotCluster2(X, alpha)
        
figure('name', 'Clusters');
plot(X(:,1), X(:,2), 'bo'), grid minor;
hold on;
for i=1:max(alpha)
    P = X(alpha == i,:);
    plot(P(:,1), P(:,2), 'o');
end
hold off;

end