%Create a 2D workspace after creating obstacles by user input

%INPUT
%fig: Figure to draw on.
%ax: Axes of the figure.

%OUTPUT
%fig: Figure after the required obstacles are plotted.
%ax: Axes of the figure.
%obstacle_coords_final: Final structure that stores obstacles (Represented
%using its vertices). Each element of the structure is a separate obstacle.

function[fig, ax, obstacle_coords_final] = createObstacles2D(fig, ax)

%User input is taken for the obstacles and is dynamically drawn.
%A return command when a current obstacle is being drawn confirms the
%obstacle by closing it.
%A return command when no current obstacle is being drawn ends the obstacle
%create process.

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

%Removing the duplicate obstacle that gets stored at the end.
obstacle_coords_final = {};
for i=1:length(obstacle_coords)-1
    obstacle_coords_final{i} = obstacle_coords{i};
end







