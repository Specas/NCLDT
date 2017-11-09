%Function to grow a single NCLDT tree from its root
function [] = growSingleTreeNCLDT(q_start, q_end, q_root, q_far, T, ws, wt, alpha, epsilon, m, ndim, lim)

%Sampling in the biased space (epsilon ball with alpha constraint)
%Sampling m points around an epsilon ball about the farthest point

q_m = zeros(m, ndim);

while true
    
    q_sample = sampleConfiguration(ndim, lim);
    
    



