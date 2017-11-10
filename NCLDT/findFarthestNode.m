%Function to find the farthest node from the root node
function [q_far] = findFarthestNode(T, q_root)

diff = T - q_root;
diff = sqrt(sum(diff.^2, 2));
[~, ind] = max(diff);
q_far = T(ind, :);