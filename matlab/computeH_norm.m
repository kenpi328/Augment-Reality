function [H2to1] = computeH_norm(x1, x2)
%[INPUT]x1 and x2 are N × 2 matrices containing the coordinates (x, y) of point pairs between the two images.
%[OUTPUT] H2to1 should be a 3 × 3 matrix for the best homography from image 2 to image 1 in the least-square sense.
%% Compute centroids of the points
centroid1 = mean(x1);
display(size(centroid1));
centroid2 = mean(x2);
%display(size(x1))
%% Shift the origin of the points to the centroid
x1 = x1 -centroid1;
x2 = x2 -centroid2;
%display(size(x1));
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).

%x’1 = T1 x1 
%x’2 = T2 x2
%x', y' is normalized homogenious coordinates
%T1 and T2 are 3x3 matrix
squareX1 =x1.*x1;
%display(size(squareX1))
squareX2 =x2.*x2;
magX1 = sqrt(squareX1(:,1) + squareX1(:,2)); %magnitude vector for x1
%display(size(magX1))
magX2 = sqrt(squareX2(:,1) + squareX2(:,2)); %magnitude vector for x2
%display(size(x1))
%display(size((x1(:,1)./magX1)));

normX1 = [(x1(:,1)./magX1).*sqrt(2), (x1(:,2)./magX1).*sqrt(2)];
normX2 = [(x2(:,1)./magX2).*sqrt(2), (x2(:,2)./magX2).*sqrt(2)];

%display(size(normX1));
%sqrt(normX1.^2 + normX2.^2) == 1
%sqrt(normX1.^2 + normX2.^2) == sqrt(2)


%% similarity transform 1
%T1 = [];
T1 = [sqrt(2), 0,  sqrt(2)*centroid1(1,1); 0, 1, sqrt(2)*centroid1(1,2); 0, 0, 1];

%% similarity transform 2
%T2 = [];
T2 = [sqrt(2), 0,  sqrt(2)*centroid2(1,1); 0, 1, sqrt(2)*centroid2(1,2); 0, 0, 1];
%% Compute Homography
H= computeH(normX1, normX2);
%% Denormalization
H2to1 = inv(T2)*H*T1;
H2to1 = H;
end
