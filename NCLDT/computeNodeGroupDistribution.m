%Function to return eta, mu, and their sizes for a particular node group
%Each of the 'm' nodes added in each iteration are placed in the two sets
%as per their definitions.
%Their sizes are also returned as almost all further computation only
%require their sizes

function [] = computeNodeGroupDistribution(Tm, rho, obstacle_coords)

eta = [];
mu = [];
size_eta = 0;
size_mu = 0;

for i=1:size(Tm, 1)
    qi = Tm(i, :);
    
    

