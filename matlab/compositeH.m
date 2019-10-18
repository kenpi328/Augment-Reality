function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
H_template_to_img = inv(H2to1);

%template is the harry potter image
%% Create mask of same size as template

mask = uint8(255*(ones(size(template))));

%% Warp mask by appropriate homography
imgSize = size(img);
warpMask = warpH(mask, H_template_to_img, imgSize);

%% Warp template by appropriate homography

warpTemplate = warpH(template, H_template_to_img, imgSize);

%% Use mask to combine the warped template and the image
cutoutBaseImg = (imcomplement(warpMask)/255).*img;
composite_img =  cutoutBaseImg + warpTemplate;

end