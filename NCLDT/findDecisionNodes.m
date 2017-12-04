%Function to find the decision nodes: The closest node in any tree and the
%closes node in a connected tree

%INPUT
%q_root: The newly sampled root node

%OUTPUT:
%q_n: The closest node among all the path nodes of all the trees
%q_nn: The closes node among all the path nodes of all the connected trees

%OUTPUT

function [q_n, q_nnc] = findDecisionNodes(q_root)

%Setting up global variables that need to be used
%Only the nodes in the path for each tree need to be considered. (Dont have
%to consider each sample point, but only the pivot points).
%To compute the closest node, we append all the paths and use the augmented
%array in a call to findNearestNode.
%To compute the closest node in a connected tree, we form the augmented
%matrix using tree_connected to find the trees that have connected

global tree_connected path

num_trees = length(path);

all_nodes = [];
connected_nodes = [];

q_n = 0;
q_nnc = 0;

for i=1:num_trees
    
    %Computed all_nodes and connected_nodes
    all_nodes = [all_nodes; path{i}];
    
    if tree_connected{i}
        connected_nodes = [connected_nodes; path{i}];
    end
end

%If any of the arrays are empty, we set the nearest node value to -1 as the
%condition in computeNewTreeDirection takes care of this and sets the
%wt direction to q_end

if isempty(all_nodes)
    q_n = -1;
else
    q_n = findNearestNode(all_nodes, q_root);
end

if isempty(connected_nodes)
    q_nnc = -1;
else
    q_nnc = findNearestNode(connected_nodes, q_root);
end


    


    



