%Function to take in a particular configuration value and return if it lies
%in the set eta.

%INPUTS:
%path: Contains all the points from qroot to qend that form a connected
%path

%OUTPUTS:
%tree_density: A value that gives the measure of difference in the points
%in the path variable


function tree_density = density(path)
sum_path = 0; 

%Size of path array
elements = size(path,1); 


%Finding out summation of L2 norm between 2 consecutive points in path
for i = 2:elements
   sum_path =  sum_path + norm(path(i)-path(i-1));
end


%Computing tree_density function
tree_density = elements/(sum_path);
end