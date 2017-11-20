%Function to grow a single NCLDT tree from its root
function [T] = growSingleTreeNCLDT(fig, ax, q_start, q_end, q_root, q_far, T, ws, wt, alpha, epsilon_min, epsilon_max, m, ndim, lim)

%Sampling in the biased space (epsilon ball with alpha constraint)
%Sampling m points around an epsilon ball about the farthest point

q_m = [];
sample_num = 0;

while sample_num < m
    
    q_sample = sampleConfigurationNSphere(ndim, q_far, epsilon_min, epsilon_max);
    if isValidSampleNCLDT(q_sample, q_far, wt, alpha)
        sample_num = sample_num + 1;
        q_m = [q_m; q_sample];
        plot(ax, q_sample(1), q_sample(2), 'b.');
        pause(0.1);      
    end
   
end

%Connecting edges
T = [T; q_m];
    
    



