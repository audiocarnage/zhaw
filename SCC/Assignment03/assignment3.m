% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: 1.0, October 2016
% 
% Assignment 3 - Transformations for pixel graphics

function [] = assignment3()

format compact; format short; clear all; clc;


source = double(imread('Pics/mignon.jpg'))./255;
%source = double(imread('Pics/sunflowers.jpg'))./255;

scaleFactor = 0.5
width = size(source,2);
height = size(source,1);
fprintf('\nSource image dimensions: height %s, width %s, bit depth %s\n\n', ...
        num2str(height), num2str(width), num2str(size(source,3)))


figure('name', 'Scaled image', 'Position', [0 300 250 250]);
imshow(backwardScaling(source, scaleFactor));

figure('name', 'Image rotated around centre', 'Position', [300 250 250 250]);
imshow(rotateAroundCentre(source, -pi/4));

figure('name', 'Image rotated around upper left corner', 'Position', [800 500 250 250]);
imshow(rotateAroundCorner(source, -3*pi/4));


% -------------------------------------------------------------------------

    function [result] = backwardScaling(source, alpha)
        
        newX = ceil(size(source,1) * alpha);
        newY = ceil(size(source,2) * alpha);
        T = inv([alpha 0 0; 0 alpha 0; 0 0 1]);
        result = ones(newX, newY, 3);
        
        for x=1:newX
            for y=1:newY
                p = [x ; y ; 1];
                q = T * p;
                assert(q(3) == 1);
                u = round(q(1));
                v = round(q(2));
                if (u > 0 && u <= size(source,1) && v > 0 && v <= size(source,2))
                    result(x,y,:) = source(u,v,:);
                end
            end
        end
    end

% -------------------------------------------------------------------------
    
    function [result] = rotateAroundCentre(source, t)
        % Rotation matrix
        R = [cos(t) -sin(t) 0; ...
             sin(t) cos(t) 0; ...
             0 0 1];

        centreOfImage = [ceil(size(source,1)/2); ceil(size(source,2)/2)]
        
        % Translation matrices
        T1 = [1 0 centreOfImage(1); 0 1 centreOfImage(2); 0 0 1];
        T2 = [1 0 -centreOfImage(1); 0 1 -centreOfImage(2); 0 0 1]; 
    
        result = ones(size(source,1), size(source,2), 3);
        
        for x=1:size(source,1)
            for y=1:size(source,2)
                p_old = [x ; y ; 1];
                q = T1*R*T2*p_old;
                assert(q(3) == 1);
                u = round(q(1));
                v = round(q(2));
                if (u > 0 && u <= size(source,1) && v > 0 && v <= size(source,2))
                    result(x,y,:) = source(u,v,:);
                end
            end
        end
    end

% -------------------------------------------------------------------------
    
    function [result] = moveImage(source, deltaX, deltaY)
       
        result = ones(2*deltaY, 2*deltaX, 3);
        
        for x=1:size(source,1)
            for y=1:size(source,2)
                p = [x ; y ; 1];
                q = p + [deltaX; deltaY; 1];
                result(q(1),q(2),:) = source(x,y,:);
            end
        end  
    end

% -------------------------------------------------------------------------
    
    function [result] = rotateAroundCorner(source, t)
        % Rotation matrix
        R = [cos(t) -sin(t) 0; ...
             sin(t) cos(t) 0; ...
             0 0 1];

        % coordinates of the upper left corner of the image
        % (centre of rotation)
        % calculation of deltaX and deltaY:
        % *  cut in half the image from corner to opposite corner
        % *  hypothenuse c of right triangle "width-height"
        % *  deltaX = deltaY = c
        c = ceil(sqrt(size(source,1)^2 + size(source,2)^2));
        fprintf('\nUpper left corner coordinates: x=%s, y=%s\n\n', num2str(c), num2str(c))
        
        % Translation matrices
        T1 = [1 0 c; 0 1 c; 0 0 1];
        T2 = [1 0 -c; 0 1 -c; 0 0 1];

        movedImage = moveImage(source, c, c);
        result = ones(size(movedImage,1), size(movedImage,2), 3);

        for x=1:size(result,1)
            for y=1:size(result,2)
                p_old = [x ; y ; 1];
                q = T1*R*T2*p_old;
                assert(q(3) == 1);
                u = round(q(1));
                v = round(q(2));
                if (u > 0 && u <= size(movedImage,1) && v > 0 && v <= size(movedImage,2))
                    result(x,y,:) = movedImage(u,v,:);
                end
            end
        end
    end

end
