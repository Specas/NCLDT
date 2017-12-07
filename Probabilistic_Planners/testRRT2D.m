%Test file to run RRT (2D version)
clear
clc
close all

%Adding path.
addpath(genpath('..\Tools\'));

%Docking figure.
set(0,'DefaultFigureWindowStyle','docked');

size_x_min = -100;
size_x_max = 100;
size_y_min = -100;
size_y_max = 100;

lim = [size_x_min, size_x_max; size_y_min, size_y_max];
ndim = 2;

%Creating Obstacle in space.
[fig, ax] = initializeFigure2D('2D Space', 'GridOn', [size_x_min size_x_max], [size_y_min, size_y_max]);
% [fig, ax, obstacle_coords] = createObstacles2D(fig, ax);
load('obstacle_coords4.mat');
%Draw filled obstacles.
[fig, ax] = drawObstacles2D(fig, ax, obstacle_coords, 'Filled');

%Selecting the start and end configurations.
fprintf('Click to select the start configuration.\n');
q_start = setConfiguration2D(fig, ax);

fprintf('Click to select the end configuration.\n');
q_end = setConfiguration2D(fig, ax);

%Carrying out RRT.
[start_nodes, start_connectivity, end_nodes, end_connectivity] = RRT(ax, obstacle_coords, q_start, q_end, ndim, lim, 'Animate');

start_pivot = size(start_connectivity, 2);
end_pivot = size(end_connectivity, 2);

path = start_nodes(end, :);

while true
    
    tmp_col = start_connectivity(:, start_pivot);
    f = find(tmp_col);
    k = f(1);
    
    tmp_q = start_nodes(k, :);
    path = [tmp_q; path];
    start_pivot = k;
    
    if(start_pivot==1)
        break;
    end
    
end

while true
    
    tmp_col = end_connectivity(:, end_pivot);
    f = find(tmp_col);
    k = f(1);
    
    tmp_q = end_nodes(k, :);
    path = [path; tmp_q];
    end_pivot = k;
    
    if(end_pivot==1)
        break;
    end
    
end

for i=1:size(path, 1)-1
    
    plot(ax, [path(i, 1), path(i+1, 1)], [path(i, 2), path(i+1, 2)], 'k-', 'LineWidth', 2);
end
disp('---------------------------------------------------');
disp('Path Found');
disp('---------------------------------------------------');
