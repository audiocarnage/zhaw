% Linear transformations

format compact; format short; clear all; clc;

v = [2 ; 1];

% Translations
u = [2 ; 3];
w = v + u

% Scaling
alpha = 0.5
m = [alpha 0; 0 alpha]
x = m * v

% Rotation
theta = pi/2
n = [cos(theta) -sin(theta); sin(theta) cos(theta)]
y = n * v

% Represent translations as matrix multiplications
% tool : homogeneous coordinates
u = [1 0 2; 0 1 3; 0 0 1]
v = [2; 1; 1]
m = [alpha 0 0; 0 alpha 0; 0 0 1]
n = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1]

% Translation
w = u * v
% Scaling
x = m * v
% Rotation
y = n * v
