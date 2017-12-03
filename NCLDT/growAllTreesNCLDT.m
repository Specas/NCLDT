function [] = growAllTreesNCLDT(fig, ax, ind, q_pivot, T, wt_current, alpha, epsilon_min, epsilon_max, epsilon_decay, m, obstacle_coords, ndim)

%Grow the trees of the particular index taking the NCLDT parameters for
%that particular index

q_m = [];
sample_num = 0;

while sample_num < m{ind}
    
    q_sample = sampleConfigurationNSphere(ndim, q_pivot{ind}, epsilon_min{ind}, epsilon_max{ind});
    if isValidSampleNCLDT(q_sample, q_pivot{ind}, wt_current{ind}, alpha{ind}) & isConfigInFree2D(q_sample, obstacle_coords) & isCollisionFreePath2D(q_pivot{ind}, q_sample, obstacle_coords)
        sample_num = sample_num + 1;
        q_m = [q_m; q_sample];
        plot(ax, q_sample(1), q_sample(2), 'b.');
        pause(0.1);
    else
        epsilon_min{ind} = epsilon_min{ind} * epsilon_decay{ind};
        epsilon_max{ind} = epsilon_max{ind} * epsilon_decay{ind};
    end
    
end

%Connecting edges
T{ind} = [T{ind}; q_m];


