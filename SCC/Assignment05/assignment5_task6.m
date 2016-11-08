% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
%
% Assignment 5 - Clustering
% Task 6

format compact; format shortE; clear all; close all; clc;

greyscaleImage = double(rgb2gray(imread('Pics/moon.jpg')))./255;
[rows,cols] = size(greyscaleImage);
V = GreyscaleImageToVector(greyscaleImage);

% divide the intensity values into 2 clusters
alpha = kmeans(V, 2);

% assign colour black to all pixels in cluster #1
V(alpha == 1, :) = 0;
% assign colour white to all pixels in cluster #2
V(alpha == 2, :) = 1;

% transform back to a greyscale image
imshow(VectorToGreyscaleImage(V, rows, cols));