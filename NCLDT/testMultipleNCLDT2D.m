%Function to generate multiple trees.
%Test file to run test NCLDT modules (2D).

clear
clc
close all

%Adding path.
addpath(genpath('..\Tools\'));

%Docking figure.
set(0,'DefaultFigureWindowStyle','docked');

size_x_min = -100;
size_x_max = 100;
size_y_min = -100;
size_y_max = 100;


lim = [size_x_min, size_x_max; size_y_min, size_y_max];
ndim = 2;

%Creating Obstacle in space.
[fig, ax] = initializeFigure2D('2D Space', 'GridOn', [size_x_min size_x_max], [size_y_min, size_y_max]);

%Create new obstacles and save them or load an existing obstacle
%configuration.
% [fig, ax, obstacle_coords] = createObstacles2D(fig, ax);
% save('obstacle_coords3.mat', 'obstacle_coords');
load('obstacle_coords2.mat');

%Draw filled obstacles.
[fig, ax] = drawObstacles2D(fig, ax, obstacle_coords, 'Filled');

%Initialize cell for storing elements related to tree.

%Global parameters for each tree.
global T Tm path wt ws wt_current rho_current alpha  epsilon_min epsilon_max
global eta mu eta_size mu_size epsilon_decay
global m q_root q_target q_pivot
global tree_energy tree_energy_decay spread
%Trees connected to q_end (Flag).
global tree_connected_end
%Trees connected to other trees (Flag).
global tree_connected_tree
%Trees decaying (Flag).
global tree_decay

%qtarget remains constant. qend will change if a tree is connected as the
%new sample points will try connecting to qtarget or exisitng trees.

%Default initial parameters.
alpha_init = 45*pi/180;
epsilon_max_init = 0;
epsilon_min_init = 0;
m_init = 3;
rho_init = 1;
tree_energy_init = 100;
tree_energy_threshold = 0.3 * tree_energy_init;
tree_energy_decay_init = 0.9;
epsilon_decay_init = 0.99;
k1 = 10^9;
k2 = 10^-9;
k3 = 3;

%Matrix to keep track of connectivity between trees
tree_connectivity = [];

%Plotting parameters.
quiver_magn = 5;

%Specify number of initial trees and a counter to count number of decayed
%trees.
num_trees = 16;
decay_counter = 0;

%Initializing the energy cap (to decide on how many trees to add) and the
%current total tree energy (for the initial batch of trees).
trees_energy_cap = 5000;
total_tree_energy = num_trees * tree_energy_init;

%Number of total trees and non connected trees.
num_nctrees = num_trees;

%Initializing tree parameters as empty cells.
T = {}; Tm = {}; path = {}; wt = {}; ws = {}; wt_current = {}; rho_current = {}; alpha = {};
epsilon_min = {}; epsilon_max = {};
eta = {}; mu = {}; eta_size = {}; mu_size = {};  m = {}; q_root = {}; q_target = {}; q_pivot = {}; epsilon_decay = {};
tree_connected_end = {}; tree_connected_tree = {}; tree_decay = {};
tree_energy = {}; tree_energy_decay = {}; spread = {};


%Selecting the start and end configurations.
fprintf('Click to select the start configuration.\n');
q_start = setConfiguration2D(fig, ax);

fprintf('Click to select the end configuration.\n');
q_end = setConfiguration2D(fig, ax);

%Creating the initial batch of uniformly sampled trees.
num_trees = createNewTreesUniform(q_start, q_end, alpha_init, epsilon_max_init, epsilon_min_init, epsilon_decay_init, m_init, rho_init, tree_energy_init, tree_energy_decay_init, num_trees, num_nctrees, obstacle_coords, ndim, lim);

done = false;

while ~done
    
    %Adding trees based on the current energy levels of the system.
    for i=1:round((trees_energy_cap - total_tree_energy)/tree_energy_init)
        createNewTree(q_start, q_end, alpha_init, epsilon_max_init, epsilon_min_init, epsilon_decay_init, m_init, rho_init, tree_energy_init, tree_energy_decay_init, num_trees, num_nctrees, obstacle_coords, ndim, lim);
        num_trees = num_trees + 1;
        num_nctrees = num_nctrees + 1;
        
        %Adding to the connectivity matrix
        tree_connectivity = [tree_connectivity, zeros(size(tree_connectivity, 1), 1)];
        tree_connectivity = [tree_connectivity; zeros(1, size(tree_connectivity, 2))];
    end
    
    fprintf('Total Energy: %.3f\n', total_tree_energy);
    %         fprintf('Trees: %d, Non-connected Trees: %d\n', num_trees, num_nctrees);
    
    %Resetting values.
    total_tree_energy = 0;
    
    for i=1:num_trees
        if tree_decay{i}
            continue
        end
        
        rho_current{i} = computeSearchRadius(rho_init, rho_current{i}, wt{i}, wt_current{i}, k1, k3);
        [eta{i}, mu{i}, eta_size{i}, mu_size{i}] = computeNodeGroupDistribution(Tm{i}, rho_current{i}, wt_current{i}, ws{i}, obstacle_coords, lim);
        
        %Non-decay condition.
        if eta_size{i} == 0 & mu_size{i} == 0
            tree_decay{i} = true;
            decay_counter = decay_counter+1;
            fprintf("Decay tree number: %d, Number of decayed trees: %d\n",i, decay_counter);
            
            %Once the tree has decayed, the algorithm moves on to the next
            %tree
            continue;
        else
            %Updating wt_current if the tree can still be grown.
            wt_current{i} = computeGrowthDirection(eta_size{i}, mu_size{i}, wt{i}, ws{i}, k1, k2);
        end
        
        %The spread is computed as the norm between the previous value of
        %q_pivot and the new value. If it is less, it means that the tree
        %has not spread out much (Energy needs to be decreased).
        if eta_size{i} == 0
            q_pivot_tmp = findNearestNode(mu{i}, q_root{i});
            spread{i} = norm(q_pivot_tmp - q_pivot{i});
            q_pivot{i} = q_pivot_tmp;
        else
            q_pivot_tmp = findNearestNode(eta{i}, q_root{i});
            spread{i} = norm(q_pivot_tmp - q_pivot{i});
            q_pivot{i} = q_pivot_tmp;
        end
        
        %Updating energies.
        tree_energy{i} = computeEnergy(tree_energy_init, tree_energy{i}, epsilon_max{i}, spread{i});
        total_tree_energy = total_tree_energy + tree_energy{i};
        
        %         fprintf('Energy of tree %d: %.3f\n', i, tree_energy{i});
        if tree_connected_end{i} | tree_connected_tree{i}
            %Once a tree is connected, further nodes will try to connect to
            %q_start, hence they must be appended before the current path
            %nodes as the order is from start to end.
            path{i} = [q_pivot{i}; path{i}];
        else
            path{i} = [path{i}; q_pivot{i}];
        end
        
        if tree_energy{i} < tree_energy_threshold
            tree_decay{i} = true;
            decay_counter = decay_counter + 1;
            fprintf("Decay tree number: %d, Number of decayed trees: %d\n",i, decay_counter);
            %Dont need to grow the tree if the decay condition is met. The
            %program moves on to the next tree.
            continue;
        end
        
        %Setting epsilon_min and epsilon_max depending on rho.
        epsilon_min{i} = rho_init;
        epsilon_max{i} = rho_current{i};
        
        [T{i}, Tm{i}] = growSingleTreeNCLDT(fig, ax, q_pivot{i}, T{i}, wt_current{i}, alpha{i}, epsilon_min{i}, epsilon_max{i}, epsilon_decay{i}, m{i}, obstacle_coords, ndim, lim);
        
        %wt and q_target is updated (Direction can be changed to connect to a
        %connected tree instead of the target). This is done using the
        %probabilistic method defined in the function
        %computeNewTreeDirection.
        %The direction is updated only if the tree is not connected. If it
        %is connected, the direction is just the unit vector pointing to
        %q_start
        if ~tree_connected_end{i} & ~tree_connected_tree{i}
            [q_n, q_nc] = findDecisionNodes(q_root{i});
            [wt{i}, q_target{i}] = computeNewTreeDirection(num_nctrees, num_trees, q_root{i}, q_n, q_nc, q_end);
        end
        
        %Plotting pivot node.
        plot(ax, q_pivot{i}(1), q_pivot{i}(2), 'c.');
        
        %Plotting direction.
        quiver(ax, q_pivot{i}(1), q_pivot{i}(2), quiver_magn * wt_current{i}(1), quiver_magn * wt_current{i}(2), 'g-');
        
        for j=size(Tm{i}, 1)
            q_tmp = Tm{i}(j, :);
            if isCollisionFreePath2D(q_tmp, q_target{i}, obstacle_coords)
                
                %Finding the tree that connected.
                connected_tree_index = findTreeContainingNode(q_target{i}, q_end);
                %Checking if it connected to q_end.
                
                %Plotting and appending to path.
                plot(ax, [q_tmp(1), q_target{i}(1)], [q_tmp(2), q_target{i}(2)], 'k-');
                path{i} = [path{i}; Tm{i}(j, :)];
                path{i} = [path{i}; q_target{i}];
                
                if isequal(q_target{i}, q_start)
                    done = true;
                    fprintf('Path Found!\n');
                    break;
                end
                
                %Check if it connected to the q_end and change the number.
                %of connected trees.
                if isequal(q_target{i}, q_end)
                    %Connected to the end.
                    tree_connected_end{i} = true;
                    num_nctrees = num_nctrees - 1;
                else
                    %Connected to another tree.
                    tree_connected_tree{i} = true;
                    plot(ax, q_target{i}(1), q_target{i}(2), 'r.', 'MarkerSize', 10);
                end
            end
        end
        
        %Once a tree is connected, dont stop it from growing. Instead
        %change its direction to q_start. Now wt is now calculated using
        %q_start and ws is calculated using q_end. Hence connected trees
        %would grow towards the start position
        if tree_connected_end{i} | tree_connected_tree{i}
            wt{i} = (q_start - q_root{i})/norm(q_start - q_root{i});
            q_target{i} = q_start;
            ws{i} = -(q_end - q_root{i})/norm(q_end - q_root{i});
        end
        
        if done
            break;
        end
    end
end


% %Drawing the final path if a path exists
% if done
%     drawPath(fig, ax, path);
% end

