% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Assignment 6 - Classification & pattern recognition
% Task 4 - skin/non-skin classification using Support Vector Machine

format compact; format short; clear all; close all; clc;

load('Datasets/skindata.mat');
load('Datasets/nonskindata.mat');

nonskin = zeros(10000, 1);
skin = ones(10000, 1);

image = double(imread('Pics/test.png'))./255;
M = rgbImage2Matrix(image);

svmStruct = svmtrain([skindata; nonskindata], [skin; nonskin])
% caution: this function uses 13.6 GB of memory on my machine
group = svmclassify(svmStruct, M);

x = size(image, 1);
y = size(image, 2);

figure('name', 'Support Vector Machine classifier');
imshow(matrix2GreyImage(group', x, y))
