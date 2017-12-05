%Function to sample a configuration in free space

%INPUT

%obstacle_coords: Structure containing coordinates of the vertices of the
%obstacles
%ndim: Number of dimensions
%lim: Limits of the configuration space

%OUTPUT

%q_sample: Sampled configuration in free C Space

function [q_sample] = sampleConfigurationFree(obstacle_coords, ndim, lim)

%Sample a point
q_sample = sampleConfiguration(ndim, lim);

%If the sample is not in free space, keep sampling
while ~isConfigInFree2D(q_sample, obstacle_coords, lim)
    q_sample = sampleConfiguration(ndim, lim);
end

