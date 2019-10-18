%Q2.1.4
close all;
clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');


[locs1, locs2] = matchPics(cv_cover, cv_desk);
%%%%matchPics%%%%
figure;
showMatchedFeatures(cv_cover, cv_desk, locs1, locs2, 'montage');
title('Showing all matches');

%%%computeH%%%
H2 = computeH_norm(locs1, locs2);

[N, ~] = size(locs1);
oneCol = ones(N,1);
locs = [locs1,oneCol];
%display(locs);
npH = H2*locs';

npH = npH';
npH(:,1) = abs(npH(:,1) ./ npH(:,3));
npH(:,2) = abs(npH(:,2) ./ npH(:,3));

npH = npH(:,1:2);
figure;
%display(np);
showMatchedFeatures(cv_cover, cv_desk, locs1, npH, 'montage');
title('Test computeH_norm ');

%%%%computeHransac%%%%
[H,inl] = computeH_ransac(locs1, locs2);
%H2 = computeH(locs1, locs2);
display(inl);
%display(H2);
%display(locs1);
[N, ~] = size(locs1);
oneCol = ones(N,1);
locs = [locs1,oneCol];
%display(locs);
np = H*locs';

np = np';
np(:,1) = abs(np(:,1) ./ np(:,3));
np(:,2) = abs(np(:,2) ./ np(:,3));

np = np(:,1:2);
inlierIdx = find(inl == 1);
figure;
%display(np);
showMatchedFeatures(cv_cover, cv_desk, locs1(inlierIdx, :), np(inlierIdx, :), 'montage');
title('Test ransacH ');

