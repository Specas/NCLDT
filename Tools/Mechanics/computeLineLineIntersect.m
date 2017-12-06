%Function that takes the end points of two lines and find the shortest
%distance between them and returns it. Also returns the point of
%intersection.
%If they intersect, it also returns a flag that represents if the
%intersection point lies within both the vector lines.

%INPUT:
%p1: One end point of the first line.
%p2: The other end point of the first line.
%q1: One end point of the second line.
%q2: The other end point of the second line.

%OUTPUT:
%pi, qi: Points on the first and second line respectively that defines the
%end points of line (of shortest distance) between the first and second
%lines. By the definition of shortest distance, this line joining pi and qi
%is perpendicular to both the first and second lines. If the lines
%intersect, pi and qi are equal to the point of intersection.
%d: The magnitude of the shortest distance between the lines. d=0 if the
%lines intersect.
%valid_intersection: 1 if the lines intersect and the point of intersection
%lies in between the end points p1, p2 and q1, q2. This is required as the
%computation computes intersections when the lines are extended beyond
%their end points. 0 if the lines do not intersect or the point of
%intersection lies outside the end points p1, p2 or q1, q2.

function [pi, qi, d, valid_intersection] = computeLineLineIntersect(p1, p2, q1, q2)

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




