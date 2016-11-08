% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Assignment 4 - Image processing using filters
% Task 3 - Motion blur

function [] = assignment4_task3()

format compact; format short; clear all; close all; clc;


source = double(imread('Pics/jetski.png'))./255;

figure('name', 'Motion blur', 'Position', [200 300 800 600]);

h = fspecial('motion', 9, 0);
imshow(imfilter(source, h));
title('Motion blur');

end
