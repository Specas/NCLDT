%Function to obtain a user input by asking them to click on a particular
%point on the figure

%INPUT
%fig: Input figure.
%ax: Axes corresponding to the input figure.

%OUTPUT
%q: Coordinates of the point clicked by the user. It is a row vector
%containing the x and y coordinates.

function [q] = setConfiguration2D(fig, ax)

%Get 2D configuration input from the user and plotting.
[x, y] = ginput(1);
q = [x, y];
plot(ax, x, y, 'b.', 'MarkerSize', 20);