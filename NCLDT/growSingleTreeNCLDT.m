%Function to grow a single NCLDT tree from its root

%INPUTS:
%fig: Input figure.
%ax: Axes of fig.
%q_pivot: Pivot node in the tree to sample from.
%T: T matrix containing all the sample points for the particular tree.
%wt_current: Current direction of growth.
%alpha: Sampling spread angle.
%epsilon_min: Minimum sampling radius.
%epsilon_max: Maximum sampling radius.
%epsilon_decay: Decay rate of the sampling radius.
%m: Number of nodes to add to the tree in each iteration.
%obstacle_coords: Coordinates of vertices of obstacles.
%ndim: Number of dimensions.
%lim: Limits of each dimension of the configuration space. It is an ndim*2
%array where each row contains the min and max limits for a dimension.

%OUTPUS:
%T: New Tree node matrix.
%qm: Matrix of m nodes added in this iteration.

function [T, q_m] = growSingleTreeNCLDT(fig, ax, q_pivot, T, wt_current, alpha, epsilon_min, epsilon_max, epsilon_decay, m, obstacle_coords, ndim, lim)

%Sampling in the biased space (epsilon ball with alpha constraint).
%Sampling m points around an epsilon ball about the pivot point.

q_m = [];
sample_num = 0;

while sample_num < m
    
    q_sample = sampleConfigurationNSphere(ndim, q_pivot, epsilon_min, epsilon_max);
    if isValidSampleNCLDT(q_sample, q_pivot, wt_current, alpha) & isConfigInFree2D(q_sample, obstacle_coords, lim) & isCollisionFreePath2D(q_pivot, q_sample, obstacle_coords)
        sample_num = sample_num + 1;
        q_m = [q_m; q_sample];
        plot(ax, q_sample(1), q_sample(2), 'b.');
        %Pause to animate the search.
        pause(0.00000001);
    else
        epsilon_min = epsilon_min * epsilon_decay;
        epsilon_max = epsilon_max * epsilon_decay;
    end
end

%Appending sampled nodes to T.
T = [T; q_m];





