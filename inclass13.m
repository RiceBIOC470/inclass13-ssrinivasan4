%Inclass 13
%GB comments
1a 70 To use this method, it is best to use a larger radial value in the morphological structuring element. Change 60 to 130+ and the resulting image is much more reasonable. 
1b 100 
1c 100
1d 100
2a 100
2b 100
2c 100
overall: 96

%Part 1. In this directory, you will find an image of some cells expressing a 
% fluorescent protein in the nucleus. 
% A. Create a new image with intensity normalization so that all the cell
% nuclei appear approximately eqully bright. 
image1=imread('Dish1Well8Hyb1Before_w0001_m0006.tif');
image1=im2double(image1);
image1_dilate=imdilate(image1, strel('disk', 60));
image1_norm=image1./image1_dilate;
imshow(image1_norm,[]);


% B. Threshold this normalized image to produce a binary mask where the nuclei are marked true. 

xmask=image1_norm > 0.95;
imshow(xmask);
% C. Run an edge detection algorithm and make a binary mask where the edges
% are marked true.
edge_im=edge(image1, 'canny',[]);
imshow(edge_im, []);

% D. Display a three color image where the orignal image is red, the
% nuclear mask is green, and the edge mask is blue. 
toshow=cat(3,im2double(xmask), imadjust(image1), im2double(edge_im));
imshow(toshow);
%Part 2. Continue with your nuclear mask from part 1. 
%A. Use regionprops to find the centers of the objects
center_mask=regionprops(xmask, 'Centroid');
centers=cat(1, center_mask.Centroid);

%B. display the mask and plot the centers of the objects on top of the
%objects
imshow(xmask);
hold on;
plot(centers(:,1), centers(:,2), '*');
hold off;

%C. Make a new figure without the image and plot the centers of the objects
%so they appear in the same positions as when you plot on the image (Hint: remember
%Image coordinates). 
plot(centers(:,1), centers(:,2), '*');
xlim([0 1024]);
ylim([0 1024]);

