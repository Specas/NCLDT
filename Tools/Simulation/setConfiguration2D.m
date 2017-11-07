function [q] = setConfiguration2D(fig, ax)

%Get 2D configuration input from the user
[x, y] = ginput(1);
q = [x, y];
plot(ax, x, y, 'b.', 'MarkerSize', 20);