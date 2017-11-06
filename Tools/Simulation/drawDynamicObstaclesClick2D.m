function [] = drawDynamicObstaclesClick2D(obstacle_coords, obstacle_count, ax)

%Only draw the last two obstacles.
%The last obstacle is the one currently being drawn. Needed for dynamic
%user visualization.
%The second last obstacle is the completed one. 
%Only these two are required as the others are drawn on the figure (The
%loop keeps calling this function). This makes it more efficient.

if obstacle_count>=2
    coord = obstacle_coords{obstacle_count-1};
    drawObstacleClosedLines2D(ax, coord);
end

%Dynamic line creation for the incomplete obstacles
coord = obstacle_coords{obstacle_count};
drawObstacleLines2D(ax, coord);

