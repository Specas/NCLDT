%Function that samples a random point within an n-sphere centered at q1
%within angular restrictions.
%General spherical coordinates for n-spheres is used to generate points in
%an n-sphere
%Such spherical coordinates only give points on the sphere. To include the
%space inside the sphere, we randomly initialize the radius to be a value
%in [epsilon_min, epsilon_max]

%The general configuration is constructed by creating a generator matrix
%with each row having separate sin and cos functions of the angles. The
%product of all elements of each row would then give the particular
%coordinate.

%Refer to https://en.wikipedia.org/wiki/N-sphere for mathematical details

%INPUT
%ndim: Number of dimensions of the configuration space.
%q1: Sample pivot point. Points are sampled along an epsilon ball (min
%and max constraints included) around q1.
%epsilon_min: The minimum value for the epsilon ball.
%epsilon_max: The maximum value for the epsilon ball.
%alpha: The angular constraints within which the point must be sampled in
%the epsilon-ball

%OUTPUT
%qs: Sampled point in the min and max bounded epsilon-ball centered around
%q1 that also satisfies angular constraints. It is an N-dimensional vector
%as the function is able to output a generalized sampler for N dimensions.

function [qs] = sampleConfigurationAngularNSphere(ndim, q1, epsilon_min, epsilon_max, alpha)

%Randomly generating r in between the epsilon limits to account for the
%solid epsilon ball.
%Also initializing each phi angle to be a random angle between -phi/2 and
%phi/2 to take care of angular restrictions.

r = epsilon_min + rand*(epsilon_max - epsilon_min);
theta = -alpha/2 + alpha*rand(ndim-1, 1);

%The last angle needs to be set to an angle between 0 and 2*pi only for
%dimensions above 2
if ndim > 2
    theta(end) = 2*pi*rand;
end

gen_mat = ones(ndim, ndim - 1);

for i=1:ndim-1
    gen_mat(i, i) = cos(theta(i));
    for j=1:i-1
        gen_mat(i, j) = sin(theta(j));
    end
end

for j=1:ndim-1
    gen_mat(end, j) = sin(theta(j));
end

%Finding the sampling point about q1.
qs = q1 + r*prod(gen_mat, 2)';
