%Function to compute the energy of a tree. It depends on the spread of the
%tree or its growth every iteration. (Distance between the root and the
%pivot)

%INPUT
%energy_max: Max value of energy for a tree.
%energy_curr: Current value of energy for the tree.
%epsilon_max: Max value of sampling radius.
%spread: Spread of the tree (Euclidean distance between successive
%q_pivots).

%OUTPUT
%energy: Updated energy for the tree

function [energy] = computeEnergy(energy_max, energy_curr, epsilon_max, spread)

%Weights to weight the contribution of energy and spread on the energy
weight_energy = 0.05;
weight_spread = 0.05;

%Exponent value
beta = weight_energy * (energy_max - energy_curr) + weight_spread * (epsilon_max - spread);
energy = energy_curr * exp(-beta);


