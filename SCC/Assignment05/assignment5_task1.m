% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Assignment 5 - Clustering
% Task 1

format compact; format shortE; clear all; close all; clc;

X = importdata('Datasets/data1.mat');
assert(size(X,2) == 2);

% tests
%X1 = importdata('Datasets/X1.mat');
X2 = importdata('Datasets/X2.mat');
%alpha1 = importdata('Datasets/alpha1.mat');
alpha2 = importdata('Datasets/alpha2.mat');

getSilhouetteValue(X2, alpha2)

figure('name','Clustering: Task 1');
plot(X(:,1), X(:,2), 'bo'), grid minor;

N_clusters = 3;
alpha = kmeans(X, N_clusters);
plotClusters(X, alpha);