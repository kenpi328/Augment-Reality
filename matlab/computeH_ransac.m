function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%bestH2to1 should be the homography H with most inliers found during RANSAC
%locs1 and locs2 are N × 2 matrices containing the x and y coordinates of the matched point pairs
%inliers is a vector of length N with a 1 at those matches that are part of the consensus set, and 0 elsewhere

%1. select randomly a subset of data since homography choose 4 points
%2. find the model for selected data
%3. Test all data against the model and determine the inlier based on
%threshhold
%if the new model is better than the best model we have so far(based on
%numbers of inliers)
%best model <-- new model

[numPoints, ~] = size(locs1);

N = 1000;
threshold  = 30;
maxNumInlier = 0;
numCheckPoints = 4;
bestH2to1 = diag(ones(1,3));
oneCol = ones(numPoints,1);
inliers = zeros(numPoints,1);

for i = 1:N
    if(numPoints >= numCheckPoints)
        idx = randperm(numPoints,numCheckPoints); %choose four points randomly
        locs1Sub = locs1(idx, :); %get subset of points
        locs2Sub = locs2(idx, :);
        currH = computeH(locs1Sub, locs2Sub);

        locs = [locs1,oneCol];
        %display(locs);
        %display(size(currH));
        newCorr = currH * locs'; 
        newCorr = newCorr';
        newCorr(:,1) = abs(newCorr(:,1) ./ newCorr(:,3));
        newCorr(:,2) = abs(newCorr(:,2) ./ newCorr(:,3));
        newCorr = newCorr(:,1:2); %new points generated by current H

        %slope?(y2-y1)./(x2-x1) many slope can be different (Can try later)
        %difference between locs2

        diff = sqrt(locs2.^2 - newCorr.^2); %Nx2 
        dist = abs(diff(:,1) + diff(:,2)); %Nx1
        foundElements = find(dist < threshold);
        currNumInlier = numel(foundElements);
        %display(find(dist < threshold));
        %display(numPoints);
        if(currNumInlier >= maxNumInlier)
            bestH2to1 = currH;
            maxNumInlier = currNumInlier;
            
            fourPointLoc = zeros(numPoints, 1);
            
            fourPointLoc(foundElements,1) = 1;
            inliers = fourPointLoc;


        end
    end
    
    
end
    

end

