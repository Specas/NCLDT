%Checking if the sampled configuration is valid (within NCLDT parameters)
function [ret] = isValidSampleNCLDT(q_sample, q_far, wt, alpha, epsilon_min, epsilon_max)

ret = false;
q_sample_unit = (q_sample - q_far)/norm(q_sample - q_far);

%Distance
r = norm(q_sample - q_far);

%Angle
angle = acos(dot(q_sample_unit, wt));

if r >= epsilon_min && r <= epsilon_max && abs(angle)<=alpha/2
    ret = true;
end



