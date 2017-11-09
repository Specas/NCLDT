function [q_sample] = sampleConfiguration(ndim, lim)

%Sample in the free configuration space (within CSpace limits)

q_sample = zeros(1, ndim);

for i=1:ndim
    %Randomly sampling within limits
    q_sample(i) = lim(i, 1) + rand*(lim(i, 2) - lim(i, 1));
end

