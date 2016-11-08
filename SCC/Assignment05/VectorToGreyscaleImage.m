% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Constructs a (r x s)-matrix (Image) by copying the elements of vector V
% column by column.
%
% input: V, a vector
%        r, the number of rows of the resulting matrix
%        s, the number of columns of the resulting matrix
% return: Image, a greyscale image

function [Image] = VectorToGreyscaleImage(V, r, s)

Image = reshape(V, r, s);

end