%Create a 2D workspace after creating obstacles by user input

clc
clear


size_x_min = -100;
size_x_max = 100;
size_y_min = -100;
size_y_max = 100;

figure('Name','2D Space','NumberTitle','off')
ax = axes;
xlim([size_x_min size_x_max]);
ylim([size_y_min size_y_max]);
grid on;


obstacle_coords = {};
obstacle_count = 0;
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
    end
    
    drawDynamicObstaclesClick2D(obstacle_coords, obstacle_count, ax);

    
    
end






