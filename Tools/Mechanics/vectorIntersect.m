%Function that takes the end points of two lines and find the shortest
%distance between them and returns it. Also returns the point of
%intersection.
%If they intersect, it also returns a flag that represents if the
%intersection point lies within both the vector lines
function [pi, qi, d, valid_intersection] = vectorIntersect(p1, p2, q1, q2)

A = dot(q1 - p1, p2 - p1);
B = dot(q2 - q1, p2 - p1);
C = dot(p2 - p1, p2 - p1);
D = dot(q1 - p1, q2 - q1);
E = dot(q2 - q1, q2 - q1);
F = dot(p2 - p1, q2 - q1);

a = [B, -C; E -F];
b = [-A; -D];
%If the lines are parallel, the determinant becomes zero

x = pinv(a)*b;

t = x(1);
s = x(2);

pi = p1 + s*(p2 - p1);
qi = q1 + t*(q2 - q1);

d = round(norm(pi - qi), 3);

%If they intersect, we also check if the intersection point lies between
%the lines.

valid_intersection = -1;

if d == 0
    if isPointBetweenVectors(pi, p1, p2) && isPointBetweenVectors(qi, q1, q2)
        valid_intersection = 1;
    else
        valid_intersection = 0;
    end
end

    


