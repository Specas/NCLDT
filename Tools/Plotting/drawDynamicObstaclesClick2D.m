%Function to draw obstacles dynamically during the 2D obstacle creation
%process. The edges joining the drawn vertices need to displayed while the
%object is being drawn to give the user a visual feedback of the relative
%size and position of the obstacle

%INPUT
%obstacle_coords: Structure containing the details of the obstacles. Each
%element of the structure contains a matrix containing vertices of an
%object in the workspace.
%obstacle_count: Current number of obstacles in the workspace (as drawn by
%the user).
%ax: Axes corresponding to the figure.

%OUTPUT
%Thefunction only plots required lines on ax.

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

%Dynamic line creation for the incomplete obstacles.
coord = obstacle_coords{obstacle_count};
drawObstacleLines2D(ax, coord);

