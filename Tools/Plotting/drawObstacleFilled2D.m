%Function to draw filled obstacles

%INPUT:
%ax: Axes of the figure
%coord: A matrix containing the x and y coordinates of an obstacle in its
%columns.

%OUTPUT:
%The function only draws the filled polygon on ax.

function [] = drawObstacleFilled2D(ax, coord)

hold on;

%Function to draw the obstacles as filled figures.
%x and y coordinate.
x = coord(:, 1);
y = coord(:, 2);

fill(ax, x, y, 'r');
