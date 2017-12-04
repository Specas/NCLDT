%Function to create a new tree node

%INPUT
%q_start: The start configuration
%q_end: The end or goal configuration
%alpha_init: Default initial value of alpha for each tree
%epsilon_max_init: Default initial epsilon_max value for each tree
%epsilon_min_init: Default initial epsilon_min value for each tree
%epsilon_decay_init: Default initial epsilon_decay value for each tree
%m_init: Default number of sampling points for each tree
%rho_init: Default initial value of rho
%num_trees: Total number of trees 
%num_nctrees: Total number of non-connected trees
%obstacle_coords: Structure containing the coordinates of the obstacles in
%the workspace
%ndim: Number of dimensions
%lim: Limits of the configuration space

%OUTPUT
%The function only changes global NCLDT values


function [] = createNewTree(q_start, q_end, alpha_init, epsilon_max_init, epsilon_min_init, epsilon_decay_init, m_init, rho_init, num_trees, num_nctrees, obstacle_coords, ndim, lim)

%Global parameters for each tree
global T Tm path wt ws wt_current rho_current alpha  epsilon_min epsilon_max epsilon_decay
global eta mu eta_size mu_size
global m q_root q_target q_pivot
global tree_connected
global tree_decay

%Initializng paramters for each tree

path{end+1} = [];

mu{end+1} = [];
eta{end+1} = [];
eta_size{end+1} = 0;
mu_size{end+1} = 0;
tree_connected{end+1} = false;
tree_decay{end+1} = false;

%Sampling new root node for the tree
q_root{end+1} = sampleConfigurationFree(obstacle_coords, ndim, lim);
T{end+1} = q_root{end};
Tm{end+1} = q_root{end};

%Computing the direction of the trees probabilistically

% wt{end+1} = (q_end - q_root{end})/norm(q_end - q_root{end});
[q_n, q_nnc] = findDecisionNodes(q_root{end});
wt{end + 1} = computeNewTreeDirection(num_nctrees, num_trees, q_root{end}, q_n, q_nnc, q_end);
ws{end+1} = -(q_start - q_root{end})/norm(q_start - q_root{end});

q_target{end+1} = q_end;

%Current direction of growth
wt_current{end+1} = wt{end};

%Variable along which you sample
q_pivot{end+1} = q_root{end};

%Current obstacle search radius=
rho_current{end+1} = rho_init;

alpha{end+1} = alpha_init;
epsilon_min{end+1}= epsilon_min_init;
epsilon_max{end+1}= epsilon_max_init;
epsilon_decay{end+1}= epsilon_decay_init;

m{end+1} = m_init;
end

