%Function to compute the energy of a tree. It depends on the spread of the
%tree or its growth every iteration. (Distance between the root and the
%pivot)

%INPUT

%OUTPUT

function [energy] = computeEnergy(energy_max, energy_prev, epsilon_max, spread)

weight_energy = 0.005;
weight_spread = 0.005;

beta = weight_energy * (energy_max - energy_prev) + weight_spread * (epsilon_max - spread);
disp(beta);
energy = energy_prev * exp(-beta);


