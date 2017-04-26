function [A] = computeAffine(tri1_pts,tri2_pts)
%COMPUTEAFFINE Compute affine transformation matrix.
%   [A] = COMPUTEAFFINE(TRI1_PTS,TRI2_PTS) 
%   returns an affine transformation matrix A between two triangles using
%   point correspondences defined in tri1_pts and tri2_pts (which are both
%   3-by-2 matrices of (x,y) locations)

%   Copyright 2017.4.25 HYPJUDY.

assert(size(tri1_pts, 1) == 3, ...
    '3 vertices of triangle 1 are required to compute affine matrix.');
assert(size(tri2_pts, 1) == 3, ...
    '3 vertices of triangle 2 are required to compute affine matrix.');

p = transpose([tri1_pts, ones(3, 1)]); % [x;y;1] or 
                                       % [[x1,x2,x3];[y1,y2,y3];[1,1,1]]
p2 = transpose([tri2_pts, ones(3, 1)]); % [x';y';1]
% Since p is 3*3 square matrix, it is invertible:
A = p2 * pinv(p); % p' = Ap, A = p'p^(-1)
A(3, :) = [0, 0, 1]; % [[a,b,tx];[c,d,ty];[0,0,1]]
end