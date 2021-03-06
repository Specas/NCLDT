%Function to check if the given configuration in 2D lies in the free
%configuration space.

%INPUT:
%q: Input configuration
%obstacle_coords: Strucutre of matrices containing the vertices of each
%obstacle.
%lim: Limits of the configuration space. The configuration point must also
%lie in the free space.

%OUTPUT:
%free: Boolean variable that outputs if the input configuration is in free
%space or not.

function [free] = isConfigInFree2D(q, obstacle_coords, lim)

%Check if the point lies in any of the obstacles.
%For each obstacle, we draw a ray from the edge of the space to the point
%and check if it intersects with each of the edges of the obstacle. If the
%number of intersections is odd, it lies inside the obstacle.

free = true;

%Checking for configuration space limits.
for i=1:length(q)
    if q(i) < lim(i, 1) | q(i) > lim(i, 2)
        free = false;
    end
end

for i=1:length(obstacle_coords)
    
    coord = obstacle_coords{i};
    [in, on] = inpolygon(q(1), q(2), coord(:, 1), coord(:, 2));
    
    if in || on
        free = false;
    end
    
end






