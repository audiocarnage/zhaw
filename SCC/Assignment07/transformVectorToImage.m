% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, November 2016
% 
% input: V, a vector
%        height
%        width
% return: M, the image matrix

function [M] = transformVectorToImage(V,height,width)
    M = reshape(V,height,width);
end