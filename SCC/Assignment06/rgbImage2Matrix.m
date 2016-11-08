% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: October 2016
% 
% Returns a vector M of an image by concatenating the columns of the image.
% 
% input: image, an RGB image
% return: M, a vector

function [M] = rgbImage2Matrix(image)

% assuming 3 bits color depths
M = reshape(image, size(image, 1) * size(image, 2), 3);

end