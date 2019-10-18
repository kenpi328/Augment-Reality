function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
[~, ~, dim1] = size(I1);
[~, ~, dim2] = size(I2);
if(dim1 >= 3)
    I1 = rgb2gray(I1);
end
if(dim2 >= 3)
    I2 = rgb2gray(I2);
end

%% Detect features in both images
%% When u want to use BRIEF descripter
feature1 = detectFASTFeatures(I1);
feature2 = detectFASTFeatures(I2);
%% When u want to use SURF descripter
%feature1 = detectSURFFeatures(I1);
%feature2 = detectSURFFeatures(I2);

%% Obtain descriptors for the computed feature locations
%% When u want to use BRIEF descripter
[desc1, locs1] = computeBrief(I1, feature1.Location);
[desc2, locs2] = computeBrief(I2, feature2.Location);

%% When u want to use SURF descripter
%[desc1, locs1] = extractFeatures(I1, feature1.Location, 'Method', 'SURF');
%[desc2, locs2] = extractFeatures(I2, feature2.Location, 'Method', 'SURF');

%% Match features using the descriptors

indexPairs = matchFeatures(desc1, desc2, 'MatchThreshold', 20, 'MaxRatio', 0.68);
locs1 = locs1(indexPairs(:,1), :); %Nx2 matrix
locs2 = locs2(indexPairs(:,2), :);
%showMatchedFeatures(I1, I2, locs1, locs2, 'montage');


end

