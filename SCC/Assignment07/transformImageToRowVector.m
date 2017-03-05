% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, November 2016
% 
% input: M, an image matrix
% return: V, the vector representation of the image matrix

function [V] = transformImageToRowVector(M)
    V = reshape(M,1,numel(M));
end