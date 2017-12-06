%Function to draw all the obstacles depending on whether it has to be
%filled or not. This is given as an optional parameter.

%INPUT:
%fig: Input figure.
%ax: Axes of the figure.
%obstacle_coords: Structure containing information regarding all the user
%drawn obstacles. Each element is a matrix containing the coordinates of
%the vertices of the specific obstacle.
%The function contains optional variable arguments that can be used
%optionally draw filled obstacles.

%OUTPUT:
%fig: Output figure after plotting.
%ax: Axes of the figure after plotting.

function [fig, ax] = drawObstacles2D(fig, ax, obstacle_coords, varargin)

if nargin<4
    %Draw non-filled objects
    for i=1:length(obstacle_coords)
        drawObstacleClosedLines2D(ax, obstacle_coords{i});
    end
    
elseif nargin==4 && strcmp(varargin{1}, 'Filled')
    for i=1:length(obstacle_coords)
        drawObstacleFilled2D(ax, obstacle_coords{i});
    end
end


