function [] = drawDynamicObstaclesClick2D(obstacle_coords, obstacle_count, ax)

hold on;
for i=1:obstacle_count
    coord = obstacle_coords{i};
    x = coord(:, 1);
    y = coord(:, 2);
    if size(x, 1)>1
        %Draw lines as there are more than 2 points
        for j=1:size(x, 1)
            start_ind = j;
            end_ind = j+1;
            if end_ind>size(x, 1)
                end_ind = 1;
            end
            start_coord = [x(start_ind), y(start_ind)];
            end_coord = [x(end_ind), y(end_ind)];
            plot(ax, [start_coord(1), end_coord(1)], [start_coord(2), end_coord(2)], 'r');
            
        end
    end
    
end

disp(obstacle_count);
disp(length(obstacle_coords));
disp(obstacle_coords);
%Dynamic line creation for the incomplete obstacles
for i=obstacle_count+1:length(obstacle_coords) - obstacle_count
    disp('dkfkd');
    coord = obstacle_coords{i};
    x = coord(:, 1);
    y = coord(:, 2);
    if size(x, 1)>1
        %Draw lines as there are more than 2 points
        for j=1:size(x, 1)-1
            start_ind = j;
            end_ind = j+1;
            start_coord = [x(start_ind), y(start_ind)];
            end_coord = [x(end_ind), y(end_ind)];
            plot(ax, [start_coord(1), end_coord(1)], [start_coord(2), end_coord(2)], 'r');
            
        end
    end

end