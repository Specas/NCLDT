%function to sample a configuration in configuration space given its
%dimension and limits of each dimension.

%INPUT:
%ndim: The number of dimensions of the configuration space.
%lim: The limits of each dimension of the configuration space. It is an
%ndim*2 array where each row contains and min and max values for that
%dimension.

%OUTPUT:
%q_sample: Sampled point in the configuration space.

function [q_sample] = sampleConfiguration(ndim, lim)

%Sample in the free configuration space (within CSpace limits).
q_sample = zeros(1, ndim);

for i=1:ndim
    %Randomly sampling within limits.
    q_sample(i) = lim(i, 1) + rand*(lim(i, 2) - lim(i, 1));
end

