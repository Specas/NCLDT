%Function to create a radial grid, given the angular separation and radial
%increment

%INPUT
%q_end: End configuration as the center of the circle to sample radially
%from.
%angular_separation: Angular separation in radians between sampling points
%in a circle
%radial_increment: Radial increment in configuration space units that
%dictates the distance between successive circles.
%obstacle_coords: Structure of arrays containing vertices of each obstacle
%in the space.
%lim: Configuration space limits. 

%OUTPUT:
%pts: All the radially sampled configurations stacked in a matrix. Each
%row contains one sampled point.

function [pts] = createRadialGrid2D(q_end, angular_separation, radial_increment, obstacle_coords, lim)

pts = [];
%pts_tmp stores points in a single circle during a particular iteration.
pts_tmp = [];

radius = 0;
done = false;

while ~done
    %Incrementing radius for the next circle point search.
    radius = radius + radial_increment;
    isOneValidPoint = false;
    
    %Iterating through all discrete angles from 0 to 360 through increments of
    %angular_separation and computing radial points. All angles are in radians.
    for i=0:angular_separation:2*pi
        x_increment = radius * cos(i);
        y_increment = radius * sin(i);
        pts_tmp = [q_end(1) + x_increment, q_end(2) + y_increment];
        if isConfigInFree2D(pts_tmp, obstacle_coords, lim)
            %It is in free C-Space.
            pts = [pts; pts_tmp];
            isOneValidPoint = true;
        end         
    end
    
    if ~isOneValidPoint
        %Circle is now outside the space limits. End sampling.
        done = true;
    end  
end




