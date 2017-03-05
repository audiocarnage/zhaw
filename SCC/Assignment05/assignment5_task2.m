% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Partitions a given dataset into clusters with k-means algorithm.
% 
% Assignment 5 - Clustering
% Task 2

format compact; format short; clear all; close all; clc;

X = importdata('Datasets/data10.mat');
assert(size(X,2) == 2);
cluster_kmeans(X);