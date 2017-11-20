%Function to find the shortest distance between a point and a line defined
%by two vectors in n-dimensional space

%Inputs:
%p: Point in n-D space
%p1: Vector representing one end-point of the line in n-D space
%p2: Vector representing the other end-point of the line

%OUTPUT;
%dist: Distance between p and the line joining p1 and p2
%pi: Projection of p onto the line along the perpendicular distance
%is_valid: Returns true if the point pi lies in between p1 and p2. False if
%outside.

%Returns NaN if p1 = p2

function [dist, pi, is_valid] = computePointLineDistance(p, p1, p2)

s = (dot(p, p1) - dot(p, p2) - dot(p1, p2) + dot(p2, p2))/(dot(p1, p1) - 2*dot(p1, p2) + dot(p2, p2));

%Point of the least distance projection of p onto the line
pi = s*p1 + (1 - s)*p2;

dist = norm(pi - p);

is_valid = isPointBetweenVectors(pi, p1, p2);
