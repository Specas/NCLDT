function [] = drawObstacles2D(ax, obstacle_coords)

%Function to draw all the obstacles
for i=1:length(obstacle_coords)
    drawObstacleClosedLines2D(ax, obstacle_coords{i});
end
