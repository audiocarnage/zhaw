% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, November 2016
%
% input: X, a single cluster of dataset
%        alpha, the cluster-indices vector

function [] = plotClusters(X, alpha)

figure('name', 'Clusters');
hold on;

switch max(alpha)
    case 2
        P1 = X(alpha == 1,:);
        P2 = X(alpha == 2,:);
        plot(P1(:,1), P1(:,2), 'bo');
        plot(P2(:,1), P2(:,2), 'go');
    case 3
        P1 = X(alpha == 1,:);
        P2 = X(alpha == 2,:);
        P3 = X(alpha == 3,:);
        plot(P1(:,1), P1(:,2), 'bo');
        plot(P2(:,1), P2(:,2), 'go');
        plot(P3(:,1), P3(:,2), 'ro');
    case 4
        P1 = X(alpha == 1,:);
        P2 = X(alpha == 2,:);
        P3 = X(alpha == 3,:);
        P4 = X(alpha == 4,:);
        plot(P1(:,1), P1(:,2), 'bo');
        plot(P2(:,1), P2(:,2), 'go');
        plot(P3(:,1), P3(:,2), 'ro');
        plot(P4(:,1), P4(:,2), 'mo');
    case 5
        P1 = X(alpha == 1,:);
        P2 = X(alpha == 2,:);
        P3 = X(alpha == 3,:);
        P4 = X(alpha == 4,:);
        P5 = X(alpha == 5,:);
        plot(P1(:,1), P1(:,2), 'bo');
        plot(P2(:,1), P2(:,2), 'go');
        plot(P3(:,1), P3(:,2), 'ro');
        plot(P4(:,1), P4(:,2), 'mo');
        plot(P5(:,1), P5(:,2), 'yo');
    otherwise
        
end

hold off;

end