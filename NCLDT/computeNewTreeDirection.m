%Function that computes initial wt for a new tree

%INPUTS
%num_nctrees: Number of trees that have not connected to the target
%num_trees: Total number of trees
%wt_c: Current wt that might need to be conserved
%q_root: New root node that is sampled
%q_n: The nearest node to the sampled root node
%q_ntc: The nearest node to the sampled root node that is a part of a
%connected tree. Value is -1 if no trees are connected
%q_end: End configuration

%OUTPUT
%wt: Initial direction the new tree should take
%q_target: The target configuration depending on the probabilistic decision


function [wt, q_target] = computeNewTreeDirection(num_nctrees, num_trees, wt_c, q_root, q_n, q_nc, q_end)

wt = 0;
q_target = 0;
fp = 0;
a = 20;

%If no trees are connected, then the probability of the new node directing
%to the target = 1
if q_nc == -1
    fp = 1;
    
else
    %x accounts for chances of the new root growing to the goal
    x = num_nctrees/num_trees;
    delta = 10^-9;
    g1 = x/(x + delta);
    
    %y accounts for the chances of the new node growing to one of the
    %connected trees. Needs to override x if the sample configuration is
    %very close to a node in a connected tree
    
    d = norm(q_n - q_nc);
    g2 = d/(a + d);
    
    fp = g1*g2;
    
end

%Now wt is computed using the probability values. A value is k is sampled
%from 1 to 100. If k <= fp*100, wt is set to the direction from the sampled
%root node to the goal

k = 1 + rand*99;
if k <= fp*100
    wt = wt_c;
    q_target = q_end;
else
    wt = (q_nc - q_root)/norm(q_nc - q_root);
    q_target = q_nc;
end


