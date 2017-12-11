%Function to create a uniform grid, given the distance between points and space
%limits.

%INPUT
%pts_dist: Required distance between points.
%lim: Limits in all dimensions.

%OUTPUT:
%pts: All the uniformly sampled configurations stacked in a matrix. Each
%row contains one sampled point.

function [pts] = createUniformGrid2D(pts_dist, obstacle_coords, lim)

pts = [];

%Creating the grid.
[X, Y] = ndgrid(lim(1, 1):pts_dist(1):lim(1, 2), lim(2, 1):pts_dist(2):lim(2, 2));

for i=1:size(X, 1)
    for j=1:size(X, 2)
        pts_tmp = [X(i, j), Y(i, j)];
        if isConfigInFree2D(pts_tmp, obstacle_coords, lim)
            pts = [pts; pts_tmp];
        end
    end
end



