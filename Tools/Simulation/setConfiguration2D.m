function [x, y] = setConfiguration2D(fig, ax)

%Get 2D configuration input from the user
[x, y] = ginput(1);

plot(ax, x, y, 'b.', 'MarkerSize', 20);