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
% save('obstacle_coords4.mat', 'obstacle_coords');
load('obstacle_coords4.mat');

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
epsilon_max_init = 10;
epsilon_min_init = 3;
m_init = 2;
rho_init = 1;
tree_energy_init = 100;
tree_energy_threshold = 30;
tree_energy_decay_init = 0.9;
epsilon_decay_init = 1.0;
k1 = 10^9;
k2 = 10^-9;
k3 = 5;

%Plotting parameters.
quiver_magn = 5;

%Specify number of initial trees.
num_trees = 25;
decay_counter = 0;

%Initializing the energy cap (to decide on how many trees to add) and the
%current total tree energy (for the initial batch of trees).
trees_energy_cap = 3000;
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
createNewTreesUniform(q_start, q_end, alpha_init, epsilon_max_init, epsilon_min_init, epsilon_decay_init, m_init, rho_init, tree_energy_init, tree_energy_decay_init, num_trees, num_nctrees, obstacle_coords, ndim, lim);

done = false;

while ~done
    
    %Adding trees based on the current energy levels of the system.
    for i=1:round((trees_energy_cap - total_tree_energy)/tree_energy_init)
        createNewTree(q_start, q_end, alpha_init, epsilon_max_init, epsilon_min_init, epsilon_decay_init, m_init, rho_init, tree_energy_init, tree_energy_decay_init, num_trees, num_nctrees, obstacle_coords, ndim, lim);
        num_trees = num_trees + 1;
        num_nctrees = num_nctrees + 1;
    end
    
        fprintf('Total Energy: %.3f\n', total_tree_energy);
%         fprintf('Trees: %d, Non-connected Trees: %d\n', num_trees, num_nctrees);
    
    %Resetting values.
    total_tree_energy = 0;
    
    for i=1:num_trees
        if tree_connected_end{i} | tree_connected_tree{i} | tree_decay{i}
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
        
        fprintf('Energy of tree %d: %.3f\n', i, tree_energy{i});
        path{i} = [path{i}; q_pivot{i}];
        
        if tree_energy{i} < tree_energy_threshold
            tree_decay{i} = true;
            decay_counter = decay_counter + 1;
            fprintf("Decay tree number: %d, Number of decayed trees: %d\n",i, decay_counter);
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
        [q_n, q_nc] = findDecisionNodes(q_root{i});
        [wt{i}, q_target{i}] = computeNewTreeDirection(num_nctrees, num_trees, q_root{i}, q_n, q_nc, q_end);

        %Plotting pivot node.
        plot(ax, q_pivot{i}(1), q_pivot{i}(2), 'c.');
        
        %Plotting direction.
        quiver(ax, q_pivot{i}(1), q_pivot{i}(2), quiver_magn*wt_current{i}(1), quiver_magn*wt_current{i}(2), 'g-');
        
        for j=size(Tm{i}, 1)
            if isCollisionFreePath2D(Tm{i}(j, :), q_target{i}, obstacle_coords)
                
                %Local tree has found a path to its q_target.
                plot(ax, [Tm{i}(j, 1), q_target{i}(1)], [Tm{i}(j, 2), q_target{i}(2)], 'k-');
                path{i} = [path{i}; Tm{i}(j, :)];
                path{i} = [path{i}; q_target{i}];
                      
                %Check if it connected to the q_end and change the number
                %of connected trees.
                if q_target{i} == q_end
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
        
        %Check if there is a connection between q_start and any of the
        %connected (end or tree) trees roots.
        if isCollisionFreePath2D(q_start, q_root{i}, obstacle_coords) & (tree_connected_end{i} | tree_connected_tree{i})
            %Found a path from the start to one of the connected trees. As
            %connected trees are all connected to q_end, it means that a
            %path from start to end has been found and the problem has been
            %solved.
            fprintf('Path Found!\n');
            plot(ax, [q_start(1), q_root{i}(1)], [q_start(2), q_root{i}(2)], 'k-');
            done = true;
            break;
        end
    end
end


% %Drawing the final path if a path exists
% if done
%     drawPath(fig, ax, path);
% end

