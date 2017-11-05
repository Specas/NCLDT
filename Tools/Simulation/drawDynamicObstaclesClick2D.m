function [] = drawDynamicObstaclesClick2D(obstacle_coords, obstacle_count, ax)

hold on;

if obstacle_count>=2
    coord = obstacle_coords{obstacle_count-1};
    constructClosedLines2D(ax, coord);
end



%Dynamic line creation for the incomplete obstacles

coord = obstacle_coords{obstacle_count};
constructLines2D(ax, coord);

