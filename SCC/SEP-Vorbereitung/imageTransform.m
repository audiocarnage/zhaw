
% load and modify images
% forward scaling

function [] = imageTransform()

format compact; format short; clear all; clc;

inputImage = double(imread('strike.jpg'))./255;
size(inputImage)
length(inputImage)

inputImage(1:100,1:50,:) = 1;
inputImage(end - 60:end,:,:) = 0;

scaleFactor = 0.5;
outputImage = scaleImage(inputImage,scaleFactor);

figure();
%imagesc(outputImage);
imshow(outputImage);

    function [outputImage] = scaleImage(image,factor)
       transformMatrix = [factor 0 0; 0 factor 0; 0 0 1];
       for i = 1:size(image,1)
        for j = 1:size(image,2)
           newPixel = transformMatrix * [i;j;1];
           u = round(newPixel(1));
           v = round(newPixel(2));
           outputImage(u,v,:) = inputImage(i,j,:);
        end
       end
    end

end