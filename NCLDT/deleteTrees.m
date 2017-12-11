%Function to delete a tree by deleting all elements of the required tree
%index from all global variables

%INPUT
%num_trees: Current total number of trees
%num_nctrees: Current total number of non-connected trees (non end
%connected)

%OUTPUT
%num_trees: Total number of trees after deletion
%num_nctrees: Total number of non-connected trees (non end connected) after
%deletion

function [num_trees, num_nctrees] = deleteTrees(num_trees, num_nctrees)

%Global variables for the trees.
global T Tm path wt ws wt_current rho_current alpha  epsilon_min epsilon_max
global eta mu eta_size mu_size epsilon_decay
global m q_root q_target q_pivot
global tree_energy tree_energy_decay spread
global tree_connected_end
global tree_connected_tree
global tree_decay

%array to store store all the tree indices that need to be deleted.
remove_array = [];

for i=1:length(T)
    if tree_decay{i}    
        remove_array = [remove_array, i];
    end
end

%Deleting.
T(remove_array) = [];
Tm(remove_array) = [];
path(remove_array) = [];
wt(remove_array) = [];
ws(remove_array) = [];
wt_current(remove_array) = [];
rho_current(remove_array) = [];
alpha(remove_array) = [];
epsilon_min(remove_array) = [];
epsilon_max(remove_array) = [];
eta(remove_array) = [];
mu(remove_array) = [];
eta_size(remove_array) = [];
mu_size(remove_array) = [];
epsilon_decay(remove_array) = [];
m(remove_array) = [];
q_root(remove_array) = [];
q_target(remove_array) = [];
q_pivot(remove_array) = [];
tree_energy(remove_array) = [];
tree_energy_decay(remove_array) = [];
spread(remove_array) = [];
tree_connected_end(remove_array) = [];
tree_connected_tree(remove_array) = [];
tree_decay(remove_array) = [];

%Update number of trees and number of non-connected trees by subtracting
%the number of trees deleted.
%As connected trees (end or tree connected) cannot be decayed, the number
%of non-connected trees is updated by simply subtracting the number of
%trees to be deleted.
num_trees = num_trees - length(remove_array);
num_nctrees = num_nctrees - length(remove_array);


