%Function to draw paths from q_start to q_end

%INPUT:
%fig: Figure
%ax: Axes of the figure to plot on
%path: Matrix where each row is a configuration of the path from start to
%end. The first node is q_start and the last node is q_end
%varargin: Optional color parameter to draw the path in a specific color

%OUTPUT:
%Only draws on ax

function [] = drawPath(fig, ax, path, varargin)

disp(nargin);

for i=1:size(path, 1)-1
    q1 = path(i, :);
    q2 = path(i+1, :);
    
    if nargin <= 3
        %If now color is specified, draw in black
        plot(ax, [q1(1), q2(1)], [q1(2), q2(2)], 'k-');
    else
        col = varargin{1};
        plot(ax, [q1(1), q2(1)], [q1(2), q2(2)], col);
    end
end