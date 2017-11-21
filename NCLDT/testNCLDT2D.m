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

%Selecting the start and end configurations
fprintf('Click to select the start configuration.\n');
q_start = setConfiguration2D(fig, ax);

fprintf('Click to select the end configuration.\n');
q_end = setConfiguration2D(fig, ax);

%Selecting tree root location
fprintf('Click to select the root configuration.\n');
q_root = setConfiguration2D(fig, ax);

wt = (q_end - q_root)/norm(q_end - q_root);
ws = -(q_start - q_root)/norm(q_start - q_root);



T = q_root;
q_far = q_root;

%NCLDT parameters
alpha = 10*pi/180;
epsilon_max = 10;
epsilon_min = 5;
m = 3;
rho_init = 2;
k1 = 10^5;
k2 = 10^-5;
k3 = 3;

%Current direction of growth
wt_current = wt;

%Current obstacle search radius
rho_current = rho_init;
% disp(rho_current);

for i=1:20
    
    [T, Tm] = growSingleTreeNCLDT(fig, ax, q_far, T, wt_current, alpha, epsilon_min, epsilon_max, m, obstacle_coords, ndim);
    q_far = findFarthestNode(T, q_root);
%     plot(ax, q_far(1), q_far(2), 'c.');

    [eta, mu, size_eta, size_mu] = computeNodeGroupDistribution(Tm, rho_current, wt, ws, obstacle_coords);
    rho_current = computeSearchRadius(rho_init, rho_current, wt, wt_current, k1, k3);
    %Non-decay condition
    if size_eta == 0 & size_mu == 0
        fprintf('Decay\n');
        break;
    else
        wt_current = computeGrowthDirection(size_eta, size_mu, wt, ws, k1, k2);    
    end
    
    fprintf('%d, %d, %3f\n', size_eta, size_mu, rho_current);
%     pause;

    
end






