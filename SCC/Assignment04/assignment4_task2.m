% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Assignment 4 - Image processing using filters
% Task 2 - Image processing with MATLAB's built-in functions

function [] = assignment4_task2()

format compact; format short; clear all; close all; clc;


source1 = double(rgb2gray(imread('Pics/monroe.png')))./255;
source2 = double(rgb2gray(imread('Pics/airplane.png')))./255;
source3 = double(rgb2gray(imread('Pics/coins.png')))./255;

figure('name', 'Image transformations using filters');

% Sharpen image:
%---------------
subplot(1,3,1), imshow(imsharpen(source1,'Radius',2,'Amount',1.2));
title('Sharpened');

% Remove noise (spikes) from image:
% ------------------------
% average = filter2(fspecial('average',[3 3]),source2);
% subplot(1,3,2), imshow(average);
% average is not bad, but can do better with medfilt2
subplot(1,3,2), imshow(medfilt2(source2));
title('Noise (spikes) removed');

% Edge detection:
% ---------------
I = zeros(size(source3));

% Filter masks
gradientFilterX = [-1 0 1; -1 0 1; -1 0 1];
gradientFilterY = [-1 -1 -1; 0 0 0; 1 1 1];

for i=1:size(source3,1)-2
    for j=1:size(source3,2)-2
        T1 = sum(sum(gradientFilterX .* source3(i:i+2,j:j+2)));
        T2 = sum(sum(gradientFilterY .* source3(i:i+2,j:j+2)));        
        I(i+1,j+1) = sqrt(T1.^2 + T2.^2);
    end
end

subplot(1,3,3), imshow(I);
title('Edge detection');

end
