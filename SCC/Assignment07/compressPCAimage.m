% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, November 2016
% 
% input: image, a bitmap image
%        n, integer representing the number of eigenvectors
%        V, a matrix whose columns represent eigenvectors
%        mean, a matrix representing the mean face
% return: imCompressed, a compressed image resulting from applying the PCA
%                       algorithm
%         vecCompressed, a vector representing the coordinates of the
%                        transformed vector

function [im_compressed,vec_transformed] = compressPCAimage(image,n,V,mean)
V1 = transformImageToColumnVector(image);
V2 = transformImageToColumnVector(mean);
[vec_transformed,im_compressed] = compressPCAVector(V1,V2,V(:,1:n));
im_compressed = transformVectorToImage(im_compressed,size(image,1),size(image,2));
    
end