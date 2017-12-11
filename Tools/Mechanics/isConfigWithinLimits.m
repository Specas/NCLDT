%Function to check if the given configuration is within configuration space
%limits. (n-dimensional).

%INPUT
%q: Input configuration to be tested. (n-dimensional).
%lim: Configuration space limits.

%OUTPUT
%ret: Boolean return value which is 1 if the configuration is within limits
%and 0 if it is not .

function ret = isConfigWithinLimits(q, lim)

ret = true;

for i=1:length(q)
    if q(i) < lim(i, 1) | q(i) > lim(i, 2)
        %Outside limits.
        ret = false;
    end
end
    

