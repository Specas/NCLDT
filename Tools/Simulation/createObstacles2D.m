%Create a 2D workspace after creating obstacles by user input

clc
clear

addpath('../Plotting/');

%Setting space limits and initializing figure
size_x_min = -100;
size_x_max = 100;
size_y_min = -100;
size_y_max = 100;

% figure('Name','2D Space','NumberTitle','off')
% ax = axes;
% grid on;
% xlabel('x');
% ylabel('y');
% xlim(ax, [size_x_min size_x_max]);
% ylim(ax, [size_y_min size_y_max]);
[fig, ax] = initializeFigure('2D Space', 'GridOn', [size_x_min size_x_max], [size_y_min, size_y_max]);


%User input is taken for the obstacles and is dynamically drawn
obstacle_coords = {};
obstacle_count = 1;
obstacle_current_coord = [];
fprintf('Click on points to define obstacles.\nPress return to finish constructing the current obstacle.\nHit return without clicking to end obstacle creation.\n\n');

while true
    
    [x, y] = ginput(1);
    if isempty(x)
        if isempty(obstacle_current_coord)
            break;
        else
            obstacle_coords = [obstacle_coords; obstacle_current_coord];
            obstacle_current_coord = [];
            obstacle_count  = obstacle_count + 1;
        end
    else
        obstacle_current_coord = [obstacle_current_coord; [x, y]];
        obstacle_coords{obstacle_count} = obstacle_current_coord;
        
    end
    
    drawDynamicObstaclesClick2D(obstacle_coords, obstacle_count, ax);


end







