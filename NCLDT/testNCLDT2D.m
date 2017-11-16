%Test file to run test NCLDT modules (2D)
clear
clc 
close all

%Adding path
addpath(genpath('..\Tools\'));

%Docking figure
set(0,'DefaultFigureWindowStyle','docked');

size_x_min = -100;
size_x_max = 100;
size_y_min = -100;
size_y_max = 100;

lim = [size_x_min, size_x_max; size_y_min, size_y_max];
ndim = 2;

%Creating Obstacle in space
[fig, ax] = initializeFigure2D('2D Space', 'GridOn', [size_x_min size_x_max], [size_y_min, size_y_max]);
% [fig, ax, obstacle_coords] = createObstacles2D(fig, ax);
load('obstacle_coords.mat');
%Draw filled obstacles
[fig, ax] = drawObstacles2D(fig, ax, obstacle_coords, 'Filled');

%Selecting the start and end configurations
fprintf('Click to select the start configuration.\n');
q_start = setConfiguration2D(fig, ax);

fprintf('Click to select the end configuration.\n');
q_end = setConfiguration2D(fig, ax);

%Selecting tree root location
fprintf('Click to select the root configuration.\n');
q_root = setConfiguration2D(fig, ax);

wt = (q_end - q_root)/norm(q_end - q_root);
ws = -(q_start - q_root)/norm(q_start - q_root);

T = q_root;
q_far = q_root;

alpha = 30*pi/180;
epsilon_max = 20;
epsilon_min = 5;
m = 3;

for i=1:10
    
    T = growSingleTreeNCLDT(fig, ax, q_start, q_end, q_root, q_far, T, ws, wt, alpha, epsilon_min, epsilon_max, m, ndim, lim);
    q_far = findFarthestNode(T, q_root);
%     plot(ax, q_far(1), q_far(2), 'c.');

    %Updating wt
    
end






