%Function to create a radial sampling of trees for the initial batch
%starting from the end configuration.
%Unlike the uniform tree initialization, the radial algorithm cannot
%maintain the exact parameters of radius and angular_separation to produce
%the exact number of trees as it also depends on the position of q_end (The
%distribution is non linear). Hence the number of trees is only used as a
%relative value to compute parameters. The output number of sampled trees
%will not be equal to the number of trees given as input.

%INPUT
%q_start: The start configuration.
%q_end: The end or goal configuration.
%alpha_init: Default initial value of alpha for each tree.
%epsilon_max_init: Default initial epsilon_max value for each tree.
%epsilon_min_init: Default initial epsilon_min value for each tree.
%epsilon_decay_init: Default initial epsilon_decay value for each tree.
%m_init: Default number of sampling points for each tree.
%rho_init: Default initial value of rho.
%tree_energy_init: Default initial value of tree energy for each tree.
%tree_energy_decay_init: Default initial value of tree decay for each tree.
%num_trees: Total number of trees.
%num_nctrees: Total number of non-connected trees.
%obstacle_coords: Structure containing the coordinates of the obstacles in
%the workspace.
%ndim: Number of dimensions.
%lim: Limits of the configuration space.

%OUTPUT
%num_trees_initial_batch: Actual number of trees that are grown in the
%initial batch (Due to obstacles, this number may be lesser than the
%required value)

%The function only changes global NCLDT values.

function [num_trees_initial_batch] = createNewTreesRadial(q_start, q_end, alpha_init, epsilon_max_init, epsilon_min_init, epsilon_decay_init, m_init, rho_init, tree_energy_init, tree_energy_decay_init, num_trees, num_nctrees, obstacle_coords, ndim, lim)

%Global parameters for each tree
global T Tm path wt ws wt_current rho_current alpha  epsilon_min epsilon_max epsilon_decay
global eta mu eta_size mu_size
global m q_root q_target q_pivot
global tree_energy tree_energy_decay spread
global tree_connected_end
global tree_connected_tree
global tree_decay
global tree_decay_count

%Sampling uniformly first

%We assume that each dimension has the same number of required nodes.
num_trees_single_dimension = round(num_trees^(1/ndim));

%Initializing angular_separation and radial_increment.
angular_separation = deg2rad(20);

%For the radial increment, the minimum norm between the min and max limits
%in each dimension is taken as the relative measure.
lim_norm = sqrt((lim(:, 1) - lim(:, 2)).^2);
radial_increment = 200*num_trees/min(lim_norm);

%Obtaining radial points.
q_pts = createRadialGrid2D(q_end, angular_separation, radial_increment, obstacle_coords, lim);

%Number of trees that are being created in the configuration space.
num_trees_initial_batch = size(q_pts, 1);

for i=1:size(q_pts, 1)
    
    %Initializng paramters for each tree.
    path{i} = [];
    mu{i} = [];
    eta{i} = [];
    eta_size{i} = 0;
    mu_size{i} = 0;
    spread{i} = 0;
    tree_decay_count{i} = 0;
    tree_connected_end{i} = false;
    tree_connected_tree{i} = false;
    tree_decay{i} = false;
    
    %Sampling new root node for the tree.
    q_root{i} = q_pts(i, :);
    T{i} = q_root{i};
    Tm{i} = q_root{i};
    
    %Computing the direction of the trees probabilistically.
    %First the nearest node and the nearest node in a connected tree are
    %computed. These are then used to compute the growth direction.
    [q_n, q_nc] = findDecisionNodes(q_root{i});
    [wt{i}, q_target{i}] = computeNewTreeDirection(num_nctrees, num_trees, q_root{i}, q_n, q_nc, q_end);
    ws{i} = -(q_start - q_root{i})/norm(q_start - q_root{i});
    
    %Current direction of growth.
    wt_current{i} = wt{i};
    
    %Variable along which you sample.
    q_pivot{i} = q_root{i};
    
    %Setting up parameters with default initial values.
    rho_current{i} = rho_init;
    
    alpha{i} = alpha_init;
    epsilon_min{i}= epsilon_min_init;
    epsilon_max{i}= epsilon_max_init;
    epsilon_decay{i}= epsilon_decay_init;
    tree_energy{i} = tree_energy_init;
    tree_energy_decay{i} = tree_energy_decay_init;
    m{i} = m_init;
    
end



