% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, November 2016
% 
% input: A, a data matrix
%        k, an integer representing the k first eigenvectors
% return: V, a matrix of the form (v1 v2 ... vk) with
%            v1, v2,...,vk representing the k first eigenvectors

function [V] = getEigenvectors(A,k)
    [V,~] = eigs(cov(A),k);
    V = fliplr(V);
end