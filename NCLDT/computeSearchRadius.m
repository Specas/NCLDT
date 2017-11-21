%Function to update the search radius

%INPUT:
%rho_init: Initial rho (Obstacle Search Radius)
%rho_current: Current rho
%wt_current: Current direction of growth
%wt: wt
%k1: Very large number (NCLDT Parameter)
%k3: Radius multiplier (NCLDt Parameter)

%OUTPUT:
%rho_current: Updated value for obstacle search radius for the current
%iteration

function rho_current = computeSearchRadius(rho_init, rho_current, wt, wt_current, k1, k3)

h3 = exp(-k1*round(norm(wt_current - wt), 3));
rho_current = k3*h3*rho_current + (1 - h3)*rho_init;

