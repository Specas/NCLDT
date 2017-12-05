%Function to return eta, mu, and their sizes for a particular node group
%Each of the 'm' nodes added in each iteration are placed in the two sets
%as per their definitions.
%Their sizes are also returned as almost all further computation only
%require their sizes

%INPUTS:
%Tm: mXn matrix containing the m n-dimensional nodes added in the current
%iteration
%rho: Radius of obstacle search for the current iteration
%wt: wt unit vector
%ws: ws unit vector
%obstacle_coords: Structure containing coordinates for vertices of the
%obstacles

%OUTPUTS:
%eta: Eta set for Tm
%mu: Mu set for Tm
%size_eta: Number of elements in eta
%size_mu: Number of elements in mu
function [eta, mu, size_eta, size_mu] = computeNodeGroupDistribution(Tm, rho, wt, ws, obstacle_coords, lim)

eta = [];
mu = [];
size_eta = 0;
size_mu = 0;

for i=1:size(Tm, 1)
    qi = Tm(i, :);
    
    if isInEta2D(qi, rho, wt, obstacle_coords, lim)
        eta = [eta; qi];
    end
    
    if isInMu2D(qi, rho, ws, obstacle_coords, lim)
        mu = [mu; qi];
    end
    
end

size_eta = size(eta, 1);
size_mu = size(mu, 1);



