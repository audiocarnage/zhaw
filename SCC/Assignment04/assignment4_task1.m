% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Assignment 4 - Image processing using filters
% Task 1 - Moving average filter
% Replace each pixel value with the weighted average of its neighbors

function [] = assignment4_task1()

format compact; format short; clear all; close all; clc;


source = double(rgb2gray(imread('Pics/sunflowers.png')))./255;

width = size(source,2);
height = size(source,1);
fprintf('\nSource image dimensions: height %s, width %s, bit depth %s\n\n', ...
        num2str(height), num2str(width), num2str(size(source,3)))

N = 1;
weight = 1/9;

% Kernel length
m = (2*N)+1;

% Filter kernel
F = weight * ones(m);

fprintf('Kernel length: %d\n\n', m);
figure('name', 'Filtered image', 'Position', [0 300 250 250]);
imshow(myfilter(source, F))


% -------------------------------------------------------------------------

    % moving average filter
    function [R] = myfilter(Im, F)
        assert(size(F,1) == m && size(F,2) == m);
        
        R = Im;
        
        for x=1:size(Im,1)
            for y=1:size(Im,2)
                filterSum = 0;
                % Convolution
                for k=-N:N
                    for l=-N:N
                        p = getIntensity(Im,x-k,y-l);
                        filterSum = filterSum + (p * F(k+N+1,l+N+1));
                    end
                end
                R(x,y) = filterSum;
            end
        end
        
    end

% -------------------------------------------------------------------------

    function [p] = getIntensity(Im,i,j)
        if (i<=N || i>=(size(Im,1)-N) || j<=N || j>=(size(Im,2)-N))
            p = 0;
        else
            p = Im(i,j);
        end
    end

end
