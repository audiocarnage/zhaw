% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Assignment 6 - Classification & pattern recognition
% Task 3 - Evaluate the algorithms of task 2

format compact; format short; clear all; close all; clc;

load('Datasets/skindata.mat');
load('Datasets/nonskindata.mat');

image = double(imread('Pics/test.png'))./255;
M = rgbImage2Matrix(image);

alpha1 = classifyNearestMean([nonskindata; skindata], M, 2) - 1;
alpha2 = classifyNearestNeighbor([nonskindata; skindata], M, 2) - 1;

x = size(image, 1);
y = size(image, 2);

figure('name', 'Nearest mean method');
imshow(matrix2GreyImage(alpha1, x, y))
figure('name', 'Nearest neighbor method');
imshow(matrix2GreyImage(alpha2, x, y))
