%Function to check if the given configuration in 2D lies in the free
%configuration space
function [free] = isConfigInFree2D(q, obstacle_coords)

%Check if the point lies in any of the obstacles
%For each obstacle, we draw a ray from the edge of the space to the point
%and check if it intersects with each of the edges of the obstacle. If the
%number of intersections is odd, it lies inside the obstacle

free = true;
for i=1:length(obstacle_coords)
    
    coord = obstacle_coords{i};
    [in, on] = inpolygon(q(1), q(2), coord(:, 1), coord(:, 2));
        
    if in || on
        free = false;
    end
    
end
            
            
        
        
        
        
    