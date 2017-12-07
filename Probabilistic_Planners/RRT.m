%Function to implement RRT. General function for n dimensions barring the
%obstacle representation. Different obstacle detection and representation
%methods will have to be used for higher dimensions.

%INPUT:
%ax: Axes of the figure on which trajectories are plotted.
%obstacle_coords: Strucutre of matrices that contain vertices of obstacles.
%q_start: Starting configuration in configuration space.
%q_end: Ending or goal configuration in configuration space.
%ndim: Number of dimensions.
%lim: Limits of each dimension. It is an ndim*2 array where each row
%contains the min and max values for each dimension.
%The function also takes an optional parameter input which decides if the
%sampled points need to be plotted as an animation, or just the final path
%needs to be plotted.

%OUTPUT:
%start_nodes: Nodes in the start tree.
%start_connectivity: Connectivity matrix for the start tree. It is a binary
%valued tree. A value of 1 in element ij means that the ith and jth node in
%the start tree are connected.
%end_nodes: Nodes in the end tree.
%end_connectivity: Connectivity matrix for the end tree similar to the
%start tree connectivity matrix.

function [start_nodes, start_connectivity, end_nodes, end_connectivity] = RRT(ax, obstacle_coords, q_start, q_end, ndim, lim, varargin)

start_nodes = q_start;
end_nodes = q_end;
start_connectivity = 0;
end_connectivity = 0;
is_animate = false;
if nargin>6
    %Animate
    if strcmp(varargin{1}, 'Animate')
        is_animate = true;
    end
    
end

while true
    
    %Sampling till a sample in the free space is found.
    q_sample = sampleConfiguration(ndim, lim);
    while ~isConfigInFree2D(q_sample, obstacle_coords, lim)
        q_sample = sampleConfiguration(ndim, lim);
    end
    
    if is_animate
        pause(0.0001);
    end
    
    plot(ax, q_sample(1), q_sample(2), 'k.', 'MarkerSize', 15);
    
    %Finding closes configurations in both trees.
    diff_start = start_nodes - q_sample;
    [~, min_ind_start] = min(sqrt(sum(diff_start.^2, 2)));
    diff_end = end_nodes - q_sample;
    [~, min_ind_end] = min(sqrt(sum(diff_end.^2, 2)));
    
    start_connected = false;
    end_connected = false;
    
    %Check if path from q_sample to the start has a clear straight line
    %path.
    if isCollisionFreePath2D(start_nodes(min_ind_start, :), q_sample, obstacle_coords)
        start_nodes = [start_nodes; q_sample];
        start_connectivity = [start_connectivity, zeros(size(start_connectivity, 1), 1)];
        start_connectivity = [start_connectivity; zeros(1, size(start_connectivity, 2))];
        start_connectivity(end, min_ind_start) = 1;
        start_connectivity(min_ind_start, end) = 1;
        start_connected = true;
        if is_animate
            plot(ax, [q_sample(1), start_nodes(min_ind_start, 1)], [q_sample(2), start_nodes(min_ind_start, 2)], 'g-', 'LineWidth', 2);
        end
        
    end
    
    if isCollisionFreePath2D(end_nodes(min_ind_end, :), q_sample, obstacle_coords)
        end_nodes = [end_nodes; q_sample];
        end_connectivity = [end_connectivity, zeros(size(end_connectivity, 1), 1)];
        end_connectivity = [end_connectivity; zeros(1, size(end_connectivity, 2))];
        end_connectivity(end, min_ind_end) = 1;
        end_connectivity(min_ind_end, end) = 1;
        end_connected = true;
        if is_animate
            plot(ax, [q_sample(1), end_nodes(min_ind_end, 1)], [q_sample(2), end_nodes(min_ind_end, 2)], 'g-', 'LineWidth', 2);
        end
        
    end
    
    if(start_connected && end_connected)
        %Path found
        break;
    end
    
end


