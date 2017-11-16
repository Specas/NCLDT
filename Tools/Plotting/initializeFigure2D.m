function [fig, ax] = initializeFigure2D(varargin)

%Initializes a figure using variable input parameters. The input parameters
%must follow the following order:
%1. Figure name
%2. 'GridOn'/'GridOff' for the grid
%3. x limits (array)
%4. y limits (array)

%Just return the default figure if there are no input parameters
if nargin == 0
    fig = figure;
    ax = axes(fig);
end

if nargin == 1
    fig = figure('Name',varargin{1},'NumberTitle','off');
    ax = axes(fig);
end

if nargin == 2
    fig = figure('Name',varargin{1},'NumberTitle','off');
    ax = axes(fig);
    if strcmp(varargin{2}, 'GridOn')
        grid on;
    elseif strcmp(varargin{2}, 'GridOff')
        grid off;
    end
end

if nargin == 3
    fig = figure('Name',varargin{1},'NumberTitle','off');
    ax = axes(fig);
    if strcmp(varargin{2}, 'GridOn')
        grid on;
    elseif strcmp(varargin{2}, 'GridOff')
        grid off;
    end
    xlim(ax, varargin{3});
end

if nargin == 4
    fig = figure('Name',varargin{1},'NumberTitle','off');
    ax = axes(fig);
    if strcmp(varargin{2}, 'GridOn')
        grid on;
    elseif strcmp(varargin{2}, 'GridOff')
        grid off;
    end
    xlim(ax, varargin{3});
    ylim(ax, varargin{4});
end

xlabel('x');
ylabel('y');
    
    