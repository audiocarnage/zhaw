% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Maximum likelihood estimation with Gaussian mixture model
%
% Assignment 5 - Clustering
% Task 4

format compact; format short; clear all; close all; clc;

X = importdata('Datasets/data10.mat');
assert(size(X,2) == 2);
cluster_gaussian_dist(X);