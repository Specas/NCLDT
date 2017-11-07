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

lim = [size_x_min, size_x_max; size_y_min, size_y_max];
ndim = 2;

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

%Carrying out RRT
[start_nodes, start_connectivity, end_nodes, end_connectivity] = RRT(ax, obstacle_coords, q_start, q_end, ndim, lim);

start_pivot = size(start_connectivity, 2);
end_pivot = size(start_connectivity, 2);

path = [];

 while true
            
    tmp_col = start_connectivity(:, start_pivot);
    f = find(tmp_col);
    k = f(1);

    tmp_q = start_nodes(k, :);
    path = [tmp_q; path];
    pivot_a = k;

    if(pivot_a==1)
        break;
    end

 end

 while true

    tmp_col = end_connectivity(:, end_pivot);
    f = find(tmp_col);
    k = f(1);

    tmp_q = end_nodes(k, :);
    path = [path; tmp_q];
    pivot_b = k;

    if(pivot_b==1)
        break;
    end

 end

 for i=1:size(path, 1)-1
     
     plot(ax, [path(i, 1), path(i+1, 1)], [path(i, 2), path(i+1, 2)], 'g-');
 end
     


