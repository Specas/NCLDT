%Test file to run RRT (2D version)
clear
clc 
close all

%Adding path
addpath(genpath('..\Tools\'));

size_x_min = -100;
size_x_max = 100;
size_y_min = -100;
size_y_max = 100;


%Creating Obstacle in space
[fig, ax] = initializeFigure('2D Space', 'GridOn', [size_x_min size_x_max], [size_y_min, size_y_max]);
[fig, ax, obstacle_coords] = createObstacles2D(fig, ax);

%Draw filled obstacles
[fig, ax] = drawObstacles2D(fig, ax, obstacle_coords, 'Filled');

%Selecting the start and end configurations
fprintf('Click to select the start configuration.\n');
q_start = setConfiguration2D(fig, ax);

fprintf('Click to select the end configuration.\n');
q_end = setConfiguration2D(fig, ax);


