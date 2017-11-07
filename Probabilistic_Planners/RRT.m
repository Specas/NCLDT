%RRT code for arbitrary dimensions 
function [start_nodes, start_connectivity, end_nodes, end_connectivity] = RRT(ax, obstacle_coords, q_start, q_end, ndim, lim)

start_nodes = q_start;
end_nodes = q_end;
start_connectivity = 0;
end_connectivity = 0;

while true

    %Sampling till a sample in the free space is found
    q_sample = sampleConfiguration(ndim, lim);
    while ~isConfigInFree2D(q_sample, obstacle_coords)
        q_sample = sampleConfiguration(ndim, lim);
    end
    
    plot(ax, q_sample(1), q_sample(2), 'k.');
    
    %Finding closes configurations in both trees
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
        plot(ax, [q_sample(1), start_nodes(min_ind_start, 1)], [q_sample(2), start_nodes(min_ind_start, 2)], 'g-');
        disp('A');
        disp(start_connectivity);
        pause;
        
    end
    
    if isCollisionFreePath2D(end_nodes(min_ind_end, :), q_sample, obstacle_coords)
        end_nodes = [end_nodes; q_sample];
        end_connectivity = [end_connectivity, zeros(size(end_connectivity, 1), 1)];
        end_connectivity = [end_connectivity; zeros(1, size(end_connectivity, 2))];
        end_connectivity(end, min_ind_end) = 1;
        end_connectivity(min_ind_end, end) = 1;
        end_connected = true;
        plot(ax, [q_sample(1), end_nodes(min_ind_end, 1)], [q_sample(2), end_nodes(min_ind_end, 2)], 'g-');
        disp('B');
        disp(end_connectivity);
        pause;
        
    end
    
    if(start_connected && end_connected)
        %Path found
        break;
    end
    
end


