% Q3.3.1
bookMov = VideoReader('../data/book.mov');
%v = VideoReader('xylophone.mp4');
sourceMov = VideoReader('../data/ar_source.mov');
bookImg = imread("../data/cv_cover.jpg"); %350â€ŠÃ—â€Š440
[bookImgRows,bookImgCols] = size(bookImg);
 
v = VideoWriter('../data/ar.avi');
open(v);
while hasFrame(bookMov) && hasFrame(sourceMov)
    bframe = readFrame(bookMov);
    [locs1,locs2] = matchPics(bookImg, bframe);
    [bestH2to1, ~] = computeH_ransac(locs2, locs1);
    
    %crop sourceFrame
    sFrame = readFrame(sourceMov); %640â€ŠÃ—â€Š360
    [sourceImgRows,sourceImgCols] = size(sFrame);
    display(sourceImgRows);
    display(bookImgRows);
    %sFrameCropped = sFrame(sourceImgRows:bookImgRows, sourceImgCols:bookImgCols);
    scaledFrame = imresize(sFrameCropped, [size(bookImg,1) size(bookImg,2)]);
 
    compositeH(inv(bestH2to1), scaledFrame, bFrame);
    writeVideo(v,compositeH(inv(bestH2to1), scaledFrame, bFrame))
end
close(v)
