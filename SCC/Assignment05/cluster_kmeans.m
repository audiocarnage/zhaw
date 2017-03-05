% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Applies the k-means algorithm to a given dataset,
% selects the best clustering with respect to the silhouette value
% and finally plots the clusters in different colours.
%
% input: data, a cluster of dataset

function [] = cluster_kmeans(data)

k = [2 3 4 5];
silhouette_values = zeros(1,length(k));
alpha = zeros(length(k), size(data,1));

for i=1:length(k)
    alpha(i,:) = kmeans(data,k(i));
    silhouette_values(i) = getSilhouetteValue(data, alpha(i,:));
end

[m,index] = max(silhouette_values);
plotClusters(data, alpha(index,:));

end