%Function to check if the sampled configuration is valid in accordance with
%NCLDT parameters.

%INPUT
%q_sampled: Sampled configuration.
%q_pivot: Pivot configuration about which points are sampled.
%wt: Unit vector direction from the root node to q_end.
%alpha: Maximum allowed sampling spread angle.

%OUTPUT:
%ret: Returns true if the sample is a valid sample and false otherwise.
function [ret] = isValidSampleNCLDT(q_sample, q_pivot, wt, alpha)

ret = false;
q_sample_unit = (q_sample - q_pivot)/norm(q_sample - q_pivot);

%Angle that the line joining the sampled point and the pivot point makes
%with wt.
angle = acos(dot(q_sample_unit, wt));

if abs(angle)<=alpha/2
    ret = true;
end



