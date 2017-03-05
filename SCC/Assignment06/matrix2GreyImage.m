% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: October 2016
% 
% Constructs a greyscale image of size r x s.
% 
% input: S, a column vector
%        r, width of image
%        s, height of image
% return: image, a greyscale image
% Example: [image] = matrix2GreyImage([0.1; 0.5; 0.4; 0.6], 2, 2)

function [image] = matrix2GreyImage(S, r, s)

image = reshape(S, r, s);

end