%RRT code for arbitrary dimensions 
function [] = RRT(q_start, q_end, ndim, lim)

%Sampling
q_sample = sampleConfiguration(ndim, lim);

