%RRT code for arbitrary dimensions 
function [] = RRT(obstacle_coords, q_start, q_end, ndim, lim)

start_nodes = q_start;
end_nodes = q_end;
start_connectivity = 0;
end_connectivity = 0;

%Sampling till a sample in the free space is found
q_sample = sampleConfiguration(ndim, lim);
while ~isConfigInFree2D(q_sample, obstacle_coords)
    q_sample = sampleConfiguration(ndim, lim);
end


