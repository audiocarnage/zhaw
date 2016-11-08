% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Returns the silhouette value of a single cluster of data.
%
% input: X, a single cluster of dataset
%        alpha, the cluster-indices vector
% return: val, the silhouette value of data cluster X

function [val] = getSilhouetteValue(X, alpha)

s = silhouette(X,alpha);
cluster_mean = zeros(1,max(alpha));
for i=1:max(alpha)
    cluster_mean(i) = mean(s(alpha == i));
end
val = mean(cluster_mean);

end