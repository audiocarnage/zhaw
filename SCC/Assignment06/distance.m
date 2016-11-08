% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: October 2016
% 
% Calculates the the euclidean distance between two points p and q.
% 
% input: p, a point
%        q, a point
% return: s, the distance
% Example: s = distance([1;2;6], [5;9;12])

function [s] = distance(p, q)

s = norm(p-q, 2);

end