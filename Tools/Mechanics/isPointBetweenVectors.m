%Function to check if a given n-dim point lies on the straight line
%joining the two vectors. All three points are assumed to be collinear
function [ret] = isPointBetweenVectors(p, p1, p2)

ret = dot(p - p1, p2 - p)/(norm(p - p1)*norm(p2 - p));

%c is 1 if it lies in between and -1 if it does not
if ret == 1
    ret = true;
else
    ret = false;
end





