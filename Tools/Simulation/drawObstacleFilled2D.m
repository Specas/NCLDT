function [] = drawObstacleFilled2D(ax, coord)

hold on;

%Function to draw the obstacles as filled figures

%x and y coordinate
x = coord(:, 1);
y = coord(:, 2);

fill(ax, x, y, 'r');
