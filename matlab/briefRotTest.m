% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
Img = imread("../data/cv_cover.jpg");
[~, ~, dim] = size(Img);

if(dim >= 3)
    Img = rgb2gray(Img);
end

%% Compute the features and descriptors

counts = zeros(1,37);
for i = 0:36
    %% Rotate image
    rotatedImg = imrotate(Img, i*10);
    
    %% Compute features and descriptors
    [locs1, locs2] = matchPics(Img, rotatedImg); %locs1, locs2 is an Nx2 matrix
    [featureNums,~] = size(locs1);
    counts(1,i+1)= featureNums;
    if(i==9 || i==18 ||i==27)
        saveas(gcf, ['BRIEFfig' num2str(i) '.png'])
    end
    
    %% Match features
    
    %% Update histogram
end
xaxis= 0:10:360;
bar(xaxis, counts);

title('BRIEF: Count of match VS orientations');
xlabel('orientations(degree)');
ylabel('Count of match');
saveas(gcf, 'BRIEFbar.png')
%% Display histogram