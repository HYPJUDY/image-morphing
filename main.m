%MAIN Main process of image morphing.
%   Produce a "morph" animation of one image into another image(e.g. faces)
%   Usage: 
%   1. Put your images (one or three channels) in input directory
%   2. Specify parameters
%   3. (Optional)Type "mex mytsearch.c" in Matlab to compile "mytsearch.c".
%      (10x faster than using mytsearch.m)
%   4. Run

%   Copyright 2017.4.25 HYPJUDY.

% --------- Specify the following parameters --------- %
im1_name = 'girl.jpg';
im2_name = 'boy.bmp';
SAVE_FRAMES = true; % 'true': save intermediate frames
frames_num = 13; % shouldn't be too large
second_each_frame = 0.1;
input_dir = 'input';
output_dir = 'output';
% ---------------------------------------------------- %

% init
% Extension of images (mean face/frames) is the same as im1 by default
[~, im1_name_, ext] = fileparts(im1_name);
[~, im2_name_, ~] = fileparts(im2_name);
im_midway_name = [im1_name_, '_', im2_name_, '_midway', ext];
gif_name = [im1_name_, '_to_', im2_name_, '.gif'];

im1_path = [input_dir, filesep, im1_name];
im2_path = [input_dir, filesep, im2_name];
im_midway_path = [output_dir, filesep, im_midway_name];
gif_path = [output_dir, filesep, gif_name];
im1_pts_path = [input_dir, filesep, im1_name_, '.mat'];
im2_pts_path = [input_dir, filesep, im2_name_, '.mat'];

assert(exist(im1_path, 'file')==2,'Path %s of image 1 not found.',im1_path);
assert(exist(im2_path, 'file')==2,'Path %s of image 2 not found.',im2_path);
if ~exist(output_dir, 'dir')
    mkdir(output_dir)
end
im1 = im2double(imread(im1_path));
im2 = im2double(imread(im2_path));
assert(size(im1,1)==size(im2,1) & size(im1,2)==size(im2,2), ...
    'Image 1 and image 2 should be of the same size!');

% Defining Correspondences
[im1_pts, im2_pts, tri] = ...
    define_correspondences(im1, im2, im1_pts_path, im2_pts_path);
% Computing the "Mid-way Face"
morphed_mean_im = morph(im1, im2, im1_pts, im2_pts, tri, 0.5, 0.5);
imwrite(morphed_mean_im, im_midway_path);
% triplot(tri,im1_pts(:,1),im1_pts(:,2));
% The Morph Sequence
frame = 0;
for frac = linspace(0, 1, frames_num)
    disp(['Processing #', num2str(frame), ' frame']);
    morphed_im = morph(im1, im2, im1_pts, im2_pts, tri, frac, frac);
    if SAVE_FRAMES == true
        frame_name = [im1_name_,'_to_',im2_name_,'_',num2str(frame),ext];
        frame_path = [output_dir, filesep, frame_name];
        imwrite(morphed_im, frame_path);
    end
    % imshow(morphed_im);
    % write to animated gif
    [A,map] = rgb2ind(morphed_im, 256);
    if frac == 0
        imwrite(A,map,gif_path,'gif','LoopCount',...
            Inf,'DelayTime',second_each_frame);
    else
        imwrite(A,map,gif_path,'gif','WriteMode',...
            'append','DelayTime',second_each_frame);
    end
    frame = frame + 1;
end

