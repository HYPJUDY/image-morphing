function morphed_im = morph(...
    im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)
%MORPH Morph image.
%   [MORPHED_IM]=MORPH(IM1,IM2,IM1_PTS,IM2_PTS,TRI,WARP_FRAC,DISSOLVE_FRAC) 
%   returns a warp between im1 and im2 using point correspondences defined 
%   in im1_pts and im2_pts (which are both n-by-2 matrices of (x,y) 
%   locations) and the triangulation structure tri. 
%   The parameters warp_frac and dissolve_frac control shape warping and 
%   cross-dissolve, respectively. For interpolation, both parameters lie
%   in the range [0,1]. They are the only parameters that will vary from
%   frame to frame in the animation.
%
%   Cross dissolving: interpolate a fraction from 0 to 1 and 
%                     use B*frac + A*(1-frac) as the frame value

%   Copyright 2017.4.25 HYPJUDY.

% Images im1 and im2 are first warped into an intermediate shape
% configuration controlled by warp_frac.
inter_shape_pts = warp_frac * im2_pts + (1 - warp_frac) * im1_pts;
im1_warp = affine_warp(im1, im1_pts, inter_shape_pts, tri);
im2_warp = affine_warp(im2, im2_pts, inter_shape_pts, tri);

% And then cross-dissolved according to dissolve_frac.
morphed_im = dissolve_frac * im2_warp + (1 - dissolve_frac) * im1_warp;
end
