%Function to find the tree that contains the given node

function [ind] = findTreeContainingNode(q, q_end)

%Index of the tree containing q.
ind = 0;

%Checking if q is the same as q_end as q_end is not present in any tree
if isequal(q, q_end)
    ind = -1;
end

%Need to access the global variable T.
global T

for i=1:length(T)
    for j=1:size(T{i}, 1)
        if isequal(T{i}(j, :), q)
            %Found node.
            ind = i;
            return
        end
    end
end
