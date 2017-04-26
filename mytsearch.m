function [t] = mytsearch(x,y,tri,X,Y)
%mytsearch - search triangulation
% 
% by David R. Martin, Boston College
% [t] = mytsearch(x,y,tri,X,Y);
%
% x,y,tri is an unrestricted triangulation
% X,Y are the query points
% t(i) gives the index (into tri) of the first triangle containing (X(i),Y(i))
% t(i) is NaN for points not in any triangle
%
% Make sure you're using the mex version of this code; it's about 15x
% faster.

% The basis for this function is the observation that for a triangle
% (A,B,C) and a point p, the point is in the triangle if the z coordinates
% of cross(B-A,p-A) and cross(B-A,C-A) have the same sign, and similarly
% for the other two sides of the triangle.  We need only compute the z
% coordinate of the cross product, which for two vectors (a,b) and (c,d) is
% ac-bd.  

t = NaN(size(X));

for j = 1:size(tri,1),
    a = tri(j,1);
    b = tri(j,2);
    c = tri(j,3);
    d1 = ((x(b)-x(a)).*(y(c)-y(a)) - (y(b)-y(a)).*(x(c)-x(a)));
    d2 = ((x(c)-x(b)).*(y(a)-y(b)) - (y(c)-y(b)).*(x(a)-x(b)));
    d3 = ((x(a)-x(c)).*(y(b)-y(c)) - (y(a)-y(c)).*(x(b)-x(c)));
    xba = x(b)-x(a); xcb = x(c)-x(b); xac = x(a)-x(c);
    yba = y(b)-y(a); ycb = y(c)-y(b); yac = y(a)-y(c);
    for i = 1:numel(t),
        if t(i)>0, continue; end
        if (xba*(Y(i)-y(a)) - yba*(X(i)-x(a))) * d1 < 0, continue; end
        if (xcb*(Y(i)-y(b)) - ycb*(X(i)-x(b))) * d2 < 0, continue; end
        if (xac*(Y(i)-y(c)) - yac*(X(i)-x(c))) * d3 < 0, continue; end
        t(i) = j;
    end
end