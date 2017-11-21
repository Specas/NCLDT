%Function to take in a particular configuration value and return if it lies
%in the set eta

%INPUTS:
%qi: The configuration point under consideration
%rho: The radius of obstacle search for the current iteration
%obstacle_coords: Structure of 2D obstacle coordinates

%OUTPUTS:
%ret: A boolean value that is true if qi lies in the set eta
function ret = isInEta2D(qi, rho, wt, obstacle_coords)

ret = false;

%Computing the new point at a distance rho from qi in the direction of wt
qi_rho = qi + rho*wt;

free = isConfigInFree2D(qi_rho, obstacle_coords);

%Checking if the new point is in free configuration space
if free
    ret = true;
end
        
        

        
        


