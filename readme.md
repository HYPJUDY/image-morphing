Produce a "morph" animation of one image into another image, which involves two parts: cross dissolving and affine warping.

Please read my [post](https://hypjudy.github.io/2017/04/25/image-morphing/) for more details about approaches, implementation, results and analysis.

# Usage
1. Put your images (one or three channels of the same size) in input directory
2. Specify parameters in main.m
3. (Optional) Type "mex mytsearch.c" in Matlab to compile "mytsearch.c". (10x faster than using mytsearch.m)
4. Run main.m
5. (Optional) If your images don't have predefined points, you will require to select points by the control point selection tool. See define_correspondences.m for more details.

# Results
![Chinese beauty morphing](https://github.com/HYPJUDY/image-morphing/blob/master/output/chinese_beauty.gif) ![A girl morph to a boy](https://github.com/HYPJUDY/image-morphing/blob/master/output/girl_to_boy.gif) ![Watson morph to Daniel](https://github.com/HYPJUDY/image-morphing/blob/master/output/A_to_B.gif) ![Peking Opera Mask Morphing](https://github.com/HYPJUDY/image-morphing/blob/master/output/f1_to_f2.gif) ![Pokemon GO spirit morphing](https://github.com/HYPJUDY/image-morphing/blob/master/output/bobo2_to_bobo3.gif)
