%Checks if there exists a collision free path between two configurations in
%2D. Done using line equations

%INPUT:
%q1: Start configuration
%q2: End configuration
%obstacle_coords: Structure containing coordinates of vertices of obstacles

%OUTPUT:
%ret: Returns true if a non collision path exists
function [ret] = isCollisionFreePath2D(q1, q2, obstacle_coords)

ret = true;
for i=1:length(obstacle_coords)
    coord = obstacle_coords{i};
    for j=1:size(coord, 1)
        start_ind = j;
        end_ind = j+1;
        if end_ind > size(coord, 1)
            end_ind = 1;
        end
        
        p1 = coord(start_ind, :);
        p2 = coord(end_ind, :);
        
        [~, ~, ~, valid_intersection] = computeLineLineIntersect(p1, p2, q1, q2);
        if valid_intersection == 1
            ret = false;
        end
    end
end
