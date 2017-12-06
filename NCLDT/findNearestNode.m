%Function to find the nearest node from the root node

%INPUTS:
%T: Matrix containing all the nodes.
%q_root: Root node to compute distance from.

%OUTPUTS:
%q_near: Nearest point from q_root.

function [q_near] = findNearestNode(T, q_root)

%The minimum value and index of the Euclidean distance is used to find the
%nearest node.
diff = T - q_root;
diff = sqrt(sum(diff.^2, 2));
[~, ind] = min(diff);
q_near = T(ind, :);