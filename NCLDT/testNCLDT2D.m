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

%Draw or load existing obstacle mat
% [fig, ax, obstacle_coords] = createObstacles2D(fig, ax);
% save('narrowpassage9.mat', 'obstacle_coords');
load('narrowpassage9.mat');

%Draw filled obstacles
[fig, ax] = drawObstacles2D(fig, ax, obstacle_coords, 'Filled');

%Selecting the start and end configurations.
fprintf('Click to select the start configuration.\n');
q_start = setConfiguration2D(fig, ax, 'g.');

fprintf('Click to select the end configuration.\n');
q_end = setConfiguration2D(fig, ax, 'm.');

%Selecting tree root location.
fprintf('Click to select the root configuration.\n');
q_root = setConfiguration2D(fig, ax, 'k.');

tic

wt = (q_end - q_root)/norm(q_end - q_root);
ws = -(q_start - q_root)/norm(q_start - q_root);

T = q_root;
Tm = T;
path = [];
q_pivot = q_root;

%NCLDT parameters.
alpha = 45*pi/180;
epsilon_max = 0;
epsilon_min = 0;
epsilon_decay = 0.99;
m = 5;
rho_init = 1;
k1 = 10^9;
k2 = 10^-9;
k3 = 5;
tree_energy_init = 100;
tree_energy = 100;
tree_energy_threshold = 30;
spread = 0;

%Current direction of growth.
wt_current = wt;

%Current obstacle search radius.
rho_current = rho_init;

done = false;

%Count for the decay condition.
decay_wait_counter = 0;
decay_wait_threshold = 100;

while ~done
    
    [eta, mu, size_eta, size_mu] = computeNodeGroupDistribution(Tm, rho_current, wt, ws, obstacle_coords, lim);
    %Non-decay condition.
    if size_eta == 0 & size_mu == 0
        %Increment decay wait counter
        decay_wait_counter = decay_wait_counter + 1;
        
        if decay_wait_counter > decay_wait_threshold
            %Decay
            fprintf('Decay\n');
            break;
        end
        epsilon_min = rho_init;
        rho_current = 2*rho_init;
        epsilon_max = rho_current;
        continue;
    else
        wt_current = computeGrowthDirection(size_eta, size_mu, wt, ws, k1, k2);
    end
    rho_current = computeSearchRadius(rho_init, rho_current, wt, wt_current, k1, k3);
        
%     fprintf('%d, %d, %.3f\n', size_eta, size_mu, rho_current);
        
    %Finding the nearest node from eta or mu (depending on their values).
    if size_eta == 0
        %Computing spread as the norm of the difference of the old and new
        %pivot.
        %delta spread is the previous spread subtracted from the current
        %spread
        q_pivot_tmp = findNearestNode(mu, q_root);
        delta_spread = norm(q_pivot_tmp - q_pivot) - spread;
        spread = norm(q_pivot_tmp - q_pivot);
        q_pivot = q_pivot_tmp;
    else
        q_pivot_tmp = findNearestNode(eta, q_root);
        delta_spread = norm(q_pivot_tmp - q_pivot) - spread;
        spread = norm(q_pivot_tmp - q_pivot);
        q_pivot = q_pivot_tmp;
    end
    
    %Updating wt based on current pivot node
%     wt = (q_end - q_pivot)/norm(q_end - q_pivot);
    
    %Computing energy
    
    path = [path; q_pivot];
    
    %Setting epsilon_min and epsilon_max depending on rho.
    epsilon_min = rho_init;
    epsilon_max = rho_current;
    
    [T, Tm] = growSingleTreeNCLDT(fig, ax, q_pivot, T, wt_current, alpha, epsilon_min, epsilon_max, epsilon_decay, m, obstacle_coords, ndim, lim);
    
    %Plotting pivot node.
    plot(ax, q_pivot(1), q_pivot(2), 'c.');
    
    %Plotting direction.
    quiver(ax, q_pivot(1), q_pivot(2), 7*wt_current(1), 7*wt_current(2), 'g-');
    
    for j=size(Tm, 1)
        if isCollisionFreePath2D(Tm(j, :), q_end, obstacle_coords)
            %Path is found.
            plot(ax, [Tm(j, 1), q_end(1)], [Tm(j, 2), q_end(2)], 'k-');
            path = [path; Tm(j, :)];
            path = [path; q_end];
            done = true;
        end
    end
end



[tree_density] = density(path)

%Drawing the final path if a path exists.
if done
    drawPath(fig, ax, path);
    
end

toc

