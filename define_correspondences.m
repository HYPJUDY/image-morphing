function [im1_pts, im2_pts, tri] = define_correspondences(...
    im1, im2, im1_pts_path, im2_pts_path)
%DEFINE_CORRESPONDENCES Define pairs of corresponding points.
%   returns pairs of corresponding points on the two images specify by 
%   their paths and the triangulation structure tri at midway shape.
%
%   The points can be load from disk or be selected by hand.
%   If select by hand from the scratch, first delete the previous mat files
%   corresponding to your image 1 and image 2 (if any). And then 
%   *select points* by the control point selection tool. 
%   Directly close the tool after you have finished selecting.
%   If you have predefined points in disk, they will be loaded and you can
%   modify the points if you like. 
%   *Select points* on features that you want to align during the morph in 
%   a consistent manner using the same ordering of all keypoints 
%   (the more points, the better the morph, generally): 
%   eyes, ears, nose, mouth, etc.
%   Attention: Do NOT select four corners of images.
%
%   The triangulation is computed by the mean of the two point sets
%   to lessen the potential triangle deformations.

%   Copyright 2017.4.25 HYPJUDY.

if exist(im1_pts_path, 'file')~=2 || exist(im2_pts_path, 'file')~=2
    [im1_pts, im2_pts] = cpselect(im1, im2, 'Wait', true);
    % append four corners, so as to cover entire image with triangles
    im1_pts = [im1_pts; [1,1]; [size(im1,2),1]; ...
        [size(im1,2),size(im1,1)]; [1,size(im1,1)]];
    im2_pts = [im2_pts; [1,1]; [size(im2,2),1]; ...
        [size(im2,2),size(im2,1)]; [1,size(im2,1)]];
    save(im1_pts_path, 'im1_pts');
    save(im2_pts_path, 'im2_pts');
else    
    im1_pts_mat = load(im1_pts_path, 'im1_pts');
    im2_pts_mat = load(im2_pts_path, 'im2_pts');
    im1_pts = im1_pts_mat(1).im1_pts;
    im2_pts = im2_pts_mat(1).im2_pts;
    % load the predefined points
    [im1_pts, im2_pts] = cpselect(im1, im2,im1_pts, im2_pts, 'Wait', true);
    save(im1_pts_path, 'im1_pts');
    save(im2_pts_path, 'im2_pts');
end
% mean of the two point sets
pts_mean = (im1_pts + im2_pts) / 2;
% The triangulation of mean points that will be used for entire morphing
% process. Each row of tri specifies a triangle defined by indices
% with respect to the points
% In other word, tri is a matrix storing three vertices's indexes of each 
% triangle. The relative order of triangles will not change so we can tell
% which triangle from src img corresponds to which triangle in dest img.
tri = delaunay(pts_mean);
triplot(tri, pts_mean(:,1), pts_mean(:,2)); % displays the triangles
end
