% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, November 2016
% 
% input: vec, a column vector representing a data point
%        m, a column vector representing the mean-vector
%        V, a matrix whose columns represent eigenvectors
% return: vec_transformed, a column vector representing the coordinates of 
%                          the transformed vector
%         vec_compressed, a column vector representing the final result of
%                         the PCA operations

function [vec_transformed,vec_compressed] = compressPCAVector(vec,m,V)
    vec_transformed = V' * (vec - m)
    vec_compressed = (V * vec_transformed) + m
end