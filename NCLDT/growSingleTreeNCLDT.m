%Function to grow a single NCLDT tree from its root

%INPUTS:
%fig: Figure
%ax: Axes of fig
%q_far: Farthest node in the tree to sample from
%wt_current: Current direction of growth
%alpha: Sampling spread angle (NCLDT parameter)
%epsilon_min: Minimum sampling radius (NCLDT parameter)
%epsilon_max: Maximum sampling radius (NCLDT parameter)
%m: Number of nodes to add to the tree in each iteration (NCLDT parameter)
%obstacle_coords: Coordinates of vertices of obstacles
%ndim: Number of dimensions

%OUTPUS:
%T: New Tree node matrix
%qm: Matrix of m nodes added in this iteration

function [T, q_m] = growSingleTreeNCLDT(fig, ax, q_pivot, T, wt_current, alpha, epsilon_min, epsilon_max, m, obstacle_coords, ndim)

%Sampling in the biased space (epsilon ball with alpha constraint)
%Sampling m points around an epsilon ball about the farthest point

q_m = [];
sample_num = 0;

epsilon_decay = 0.99;

while sample_num < m
    
    q_sample = sampleConfigurationNSphere(ndim, q_pivot, epsilon_min, epsilon_max);
    if isValidSampleNCLDT(q_sample, q_pivot, wt_current, alpha) & isConfigInFree2D(q_sample, obstacle_coords) & isCollisionFreePath2D(q_pivot, q_sample, obstacle_coords)
        sample_num = sample_num + 1;
        q_m = [q_m; q_sample];
        plot(ax, q_sample(1), q_sample(2), 'b.');
        pause(0.1);
    else
        epsilon_min = epsilon_min * epsilon_decay;
        epsilon_max = epsilon_max * epsilon_decay;
    end
    
end

%Connecting edges
T = [T; q_m];





