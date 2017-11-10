%Function to grow a single NCLDT tree from its root
function [T] = growSingleTreeNCLDT(fig, ax, q_start, q_end, q_root, q_far, T, ws, wt, alpha, epsilon_min, epsilon_max, m, ndim, lim)

%Sampling in the biased space (epsilon ball with alpha constraint)
%Sampling m points around an epsilon ball about the farthest point

q_m = [];
sample_num = 0;

while true
    
    q_sample = sampleConfiguration(ndim, lim);
    
    if isValidSampleNCLDT(q_sample, q_far, wt, alpha, epsilon_min, epsilon_max) && norm(q_sample - q_root) >= norm(q_far - q_root) && sample_num<=m
        sample_num = sample_num + 1;
        q_m = [q_m; q_sample];
        plot(ax, q_sample(1), q_sample(2), 'b.');
        pause(0.2);
        break;
    end
    
    
%     pause;
end

%Connecting edges
T = [T; q_m];
    
    



