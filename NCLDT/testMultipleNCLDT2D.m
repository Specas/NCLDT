%Function to generate multiple trees
%Test file to run test NCLDT modules (2D)
clear
clc
close all

%Adding path
addpath(genpath('..\Tools\'));

%Docking figure
set(0,'DefaultFigureWindowStyle','docked');

size_x_min = -100;
size_x_max = 100;
size_y_min = -100;
size_y_max = 100;



lim = [size_x_min, size_x_max; size_y_min, size_y_max];
ndim = 2;

%Creating Obstacle in space
[fig, ax] = initializeFigure2D('2D Space', 'GridOn', [size_x_min size_x_max], [size_y_min, size_y_max]);
% [fig, ax, obstacle_coords] = createObstacles2D(fig, ax);
load('obstacle_coords.mat');

%Draw filled obstacles
[fig, ax] = drawObstacles2D(fig, ax, obstacle_coords, 'Filled');

%Initialize cell for storing elements related to tree

%Global parameters for each tree
global T Tm path wt ws wt_current rho_current alpha  epsilon_min epsilon_max
global eta mu eta_size mu_size epsilon_decay
global m q_root q_target q_pivot
global tree_connected %Trees connected to end pt
global tree_decay

%qtarget remains constant. qend will change if a tree is connected as the
%new sample points will try connecting to qtarget or exisitng trees.

%NCLDT parameters
alpha_init = 45*pi/180;
epsilon_max_init = 10;
epsilon_min_init = 3;
m_init = 5;
rho_init = 0.1;
epsilon_decay_init = 0.99;
k1 = 10^5;
k2 = 10^-5;
k3 = 5;

%Specify number of initial trees
num_trees=5;

%Number of total trees and non connected trees
num_nctrees = 5;

%Initializing tree parameters as empty cells
T={}; Tm={}; path={}; wt={}; ws={}; wt_current={}; rho_current={}; alpha={};
epsilon_min={}; epsilon_max={};
eta={}; mu={}; eta_size={}; mu_size={};  m={}; q_root={}; q_target ={}; q_pivot={}; epsilon_decay={};
tree_connected={};
tree_decay={};

%Selecting the start and end configurations
fprintf('Click to select the start configuration.\n');
q_start = setConfiguration2D(fig, ax);

fprintf('Click to select the end configuration.\n');
q_end = setConfiguration2D(fig, ax);

for i=1:num_trees
    createNewTree(q_start, q_end, alpha_init, epsilon_max_init, epsilon_min_init, epsilon_decay_init, m_init, rho_init, num_trees, num_nctrees, obstacle_coords, ndim, lim);
end

done= false;

while ~done
    for i=1:num_trees
        if tree_connected{i} | tree_decay{i}
            continue
        end
%         growAllTreesNCLDT(fig, ax, i, obstacle_coords, ndim)
        
        rho_current{i} = computeSearchRadius(rho_init, rho_current{i}, wt{i}, wt_current{i}, k1, k3);
        [eta{i}, mu{i}, eta_size{i}, mu_size{i}] = computeNodeGroupDistribution(Tm{i}, rho_current{i}, wt{i}, ws{i}, obstacle_coords);
        
        %Non-decay condition
        if eta_size{i} == 0 & mu_size{i} == 0
            tree_decay{i} = true;
            fprintf('Decay Tree:');
            fprintf("%d\n",i);   
            continue;
        else
            wt_current{i} = computeGrowthDirection(eta_size{i}, mu_size{i}, wt{i}, ws{i}, k1, k2);
        end
        
        %Finding the nearest node from eta or mu (depending on their values)
        if eta_size{i} == 0
            q_pivot{i} = findNearestNode(mu{i}, q_root{i});
        else
            q_pivot{i} = findNearestNode(eta{i}, q_root{i});
        end
        
        path{i} = [path{i}; q_pivot{i}];
        
        
        %Setting epsilon_min and epsilon_max depending on rho
        epsilon_min{i} = rho_init;
        epsilon_max{i} = rho_current{i};
        
        [T{i}, Tm{i}] = growSingleTreeNCLDT(fig, ax, q_pivot{i}, T{i}, wt_current{i}, alpha{i}, epsilon_min{i}, epsilon_max{i}, m{i}, obstacle_coords, ndim);
        
        %Plotting pivot node
        plot(ax, q_pivot{i}(1), q_pivot{i}(2), 'c.');
        
        %Plotting direction
        quiver(ax, q_pivot{i}(1), q_pivot{i}(2), 7*wt_current{i}(1), 7*wt_current{i}(2), 'g-');
        
        for j=size(Tm{i}, 1)
            if isCollisionFreePath2D(Tm{i}(j, :), q_target{i}, obstacle_coords)
                
                %Path is found
                plot(ax, [Tm{i}(j, 1), q_end(1)], [Tm{i}(j, 2), q_end(2)], 'k-');
                path{i} = [path{i}; Tm{i}(j, :)];
                path{i} = [path{i}; q_end];
                tree_connected{i} = true;
                
                %Check if it connected to the q_end and change the number
                %of connected trees
                if q_target{i} == q_end
                    num_nctrees = num_nctrees - 1;
                end
                %done = true;
            end
            
        end
    end
end


% %Drawing the final path if a path exists
% if done
%     drawPath(fig, ax, path);
% end

