%Function to take in a particular configuration value and return if it lies
%in the set eta

%INPUTS:
%qi: The configuration point under consideration
%rho: The radius that is used to update the direction of growth
%obstacle_coords: Structure of 2D obstacle coordinates

%OUTPUTS:
%ret: A boolean value that is true if qi lies in the set eta
function ret = isInEta2D(qi, rho, obstacle_coords)

%We search about qi around a radius of R
%In 2D this can be done using measuring the shortest distance from qi to
%any of the line segments joining any of the obstacles

ret = false;

%Computing max distance to any obstacle
r_max = 0;
for i=1:length(obstacle_coords)
    for j=1:size(obstacle_coords{i}, 1)
        p1 = obstacle_coords{i}(j, :);
        p2 = obstacle_coords{i}(1, :);
        if j<size(obstacle_coords{i}, 1)
            p2 = obstacle_coords{i}(j+1, :);
        end
        
        [dist, ~, is_valid] = computePointLineDistance(qi, p1, p2);
        
        if dist>r_max & is_valid
            r_max = dist;
        end
    end
end

if r_max <= rho
    ret = true;
end
        
        

        
        


