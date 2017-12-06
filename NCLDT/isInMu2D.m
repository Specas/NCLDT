%Function to take in a particular configuration value and return if it lies
%in the set mu

%INPUTS:
%qi: The configuration point under consideration
%rho: The radius of obstacle search for the current iteration
%ws: Intrinsic direction (Unit vector away from q_start).
%obstacle_coords: Structure of 2D obstacle coordinates
%lim: Limits of each dimension of the configuration space. It is an ndim*2
%array where each row contains the min and max limits for a dimension.

%OUTPUTS:
%ret: A boolean value that is true if qi lies in the set mu.

function ret = isInMu2D(qi, rho, ws, obstacle_coords, lim)

ret = false;
main_collision = false;

%Computing the new point at a distance rho from qi in the direction of wt.
qi_rho = qi + rho*ws;

for i=1:length(obstacle_coords)
    for j=1:size(obstacle_coords{i}, 1)
        p1 = obstacle_coords{i}(j, :);
        p2 = obstacle_coords{i}(1, :);
        if j ~= size(obstacle_coords{i}, 1)
            p2 = obstacle_coords{i}(j+1, 1);
        end
        [~, ~, ~, valid_intersection] = computeLineLineIntersect(p1, p2, qi, qi_rho);
        
        if valid_intersection
            main_collision = true;
        end
    end
end

free = isConfigInFree2D(qi_rho, obstacle_coords, lim);

%Checking if the new point is in free configuration space.
if free & ~main_collision
    ret = true;
end







