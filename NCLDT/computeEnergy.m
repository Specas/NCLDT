%Function to compute the energy of a tree. It depends on the spread of the
%tree or its growth every iteration. (Distance between the root and the
%pivot)

%INPUT

%OUTPUT

function [energy] = computeEnergy(energy_prev, energy_decay, spread)

energy = energy_prev * energy_decay + spread;

