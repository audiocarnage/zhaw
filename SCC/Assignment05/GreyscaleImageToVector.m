% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Takes as input a greyscale image and constructs a vector
% by concatenating the columns of the image.
% 
% input: Image, a greyscale image
% return: V, vector by concatenating the columns of Image

function [V] = GreyscaleImageToVector(Image)

[rows,cols] = size(Image);
V = reshape(Image, [rows * cols, 1]);

end