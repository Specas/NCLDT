%Function to check if a given n-dim point lies on the straight line
%joining the two vectors. All three points are assumed to be collinear.

%INPUT:
%p: Input point
%p1: Start point of the vector.
%p2: End point of the vector.

%OUTPUT:
%ret: Returns true if the point is in between the vector end-points and
%false if it is not.

function [ret] = isPointBetweenVectors(p, p1, p2)

ret = round(dot(p - p1, p2 - p)/(norm(p - p1)*norm(p2 - p)), 3);

%c is 1 if it lies in between and -1 if it does not
if ret == 1
    ret = true;
else
    ret = false;
end





