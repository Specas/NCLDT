%Function to join all the coordinates in coord. Each row of coord contains
%an x and y coordinate. Lines are drawn between consecutive lines.
%The first and last points are joined. Hence a closed figure is formed.

%INPUT
%ax: Axes corresponding to the figure
%coord: A matrix containing the x and y coordinates of an obstacle in its
%columns.

%OUTPUT
%The function only draws the obstacle on ax.

function [] = drawObstacleClosedLines2D(ax, coord)

hold on;

%x and y coordinate
x = coord(:, 1);
y = coord(:, 2);

%Drawing a line only if there is more than one point
if size(x, 1)>1
    for j=1:size(x, 1)
        start_ind = j;
        end_ind = j+1;
        %Wrapping around to join the last point with the first
        if end_ind>size(x, 1)
            end_ind = 1;
        end
        start_coord = [x(start_ind), y(start_ind)];
        end_coord = [x(end_ind), y(end_ind)];
        plot(ax, [start_coord(1), end_coord(1)], [start_coord(2), end_coord(2)], 'r');
    end
end