%Function to create a new tree node

function [] = createNewTree(T, Tm, path, wt, ws, wt_current, rho_current, alpha, epsilon_min, epsilon_max, eta, mu, size_eta, size_mu, m, q_pivot, q_end, obstacle_coords, ndim, lim)

%Finding current number of trees
num_trees = length(T);

%Sampling new root node for the tree
q_root = sampleConfigurationFree(obstacle_coords, ndim, lim);

