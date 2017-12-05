%Function to compute the energy of a tree. It depends on the spread of the
%tree or its growth every iteration. (Distance between the root and the
%pivot)

%INPUT

%OUTPUT

function [energy] = computeEnergy(energy_prev, energy_decay, spread, avg_spread)

k = 0.01;
% energy = energy_prev * energy_decay + spread;
energy = energy_prev * exp(-k*abs(spread - avg_spread));

