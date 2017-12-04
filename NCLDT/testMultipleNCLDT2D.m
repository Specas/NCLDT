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

%Initializing tree parameters as empty cells
T={}; Tm={}; path={}; wt={}; ws={}; wt_current={}; rho_current={}; alpha={};
epsilon_min={}; epsilon_max={};
eta={}; mu={}; eta_size={}; mu_size={};  m={}; q_root={}; q_target ={}; q_pivot={}; epsilon_decay={};

%Specify number of initial trees
num_trees=5;

%Selecting the start and end configurations
fprintf('Click to select the start configuration.\n');
q_start = setConfiguration2D(fig, ax);

fprintf('Click to select the end configuration.\n');
q_end = setConfiguration2D(fig, ax);

for i=1:num_trees
    createNewTree(q_start,q_end, alpha_init,epsilon_max_init,epsilon_min_init,epsilon_decay_init,m_init,rho_init,obstacle_coords, ndim, lim);
end

done= false

while ~done
    for i=1:num_trees
        growAllTreesNCLDT(fig, ax, i, obstacle_coords, ndim)
    end
end

