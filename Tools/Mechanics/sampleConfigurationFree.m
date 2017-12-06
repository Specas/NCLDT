%Function to sample a configuration in free configuration space.

%INPUT:
%obstacle_coords: Structure of matrices containing the coordinates of
%obstacles in the configuration space.
%ndim: The number of dimensions of the configuration space
%lim: The limits of each dimension of the configuration space. It is an
%ndim*2 array where each row contains and min and max values for that
%dimension.

%OUTPUT:
%q_sample: Sampled point in the free configuration space.

function [q_sample] = sampleConfigurationFree(obstacle_coords, ndim, lim)

%Sample a point.
q_sample = sampleConfiguration(ndim, lim);

%If the sample is not in free space, keep sampling.
while ~isConfigInFree2D(q_sample, obstacle_coords, lim)
    q_sample = sampleConfiguration(ndim, lim);
end

