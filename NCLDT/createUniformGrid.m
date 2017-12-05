%Function to create a uniform grid, given the distance between points and space
%limits for a general n-dimensional space

%INPUT
%pts_dist: Required distance between points
%ndim: Number of dimensions
%lim: Limits in all dimensions

function [pts] = createUniformGrid(pts_dist, obstacle_coords, ndim, lim)

pts = [];

%Currently computing specifically for a 2D case
[X, Y] = ndgrid(lim(1, 1):pts_dist(1):lim(1, 2), lim(2, 1):pts_dist(2):lim(2, 2));

for i=1:size(X, 1)
    for j=1:size(X, 2)
        pts_tmp = [X(i, j), Y(i, j)];
        if isConfigInFree2D(pts_tmp, obstacle_coords, lim)
            pts = [pts; pts_tmp];
        end
    end
end



