%Function to find the farthest node from the root node

%INPUTS:
%T: Matrix containing all the nodes
%q_root: Root node to compute distance from

%OUTPUTS:
%q_far: Farthest point from q_root

function [q_far] = findFarthestNode(T, q_root)

diff = T - q_root;
diff = sqrt(sum(diff.^2, 2));
[~, ind] = max(diff);
q_far = T(ind, :);