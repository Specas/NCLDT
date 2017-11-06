function [fig, ax] = drawObstacles2D(fig, ax, obstacle_coords, varargin)

%Function to draw all the obstacles depending on whether it has to be
%filled or not. This is given as an optional parameter
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


