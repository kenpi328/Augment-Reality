function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
%[INPUT]x1 and x2 are N × 2 matrices containing the coordinates (x, y) of point pairs between the two images.
%[OUTPUT] H2to1 should be a 3 × 3 matrix for the best homography from image 2 to image 1 in the least-square sense.
%x1 ≡ H x2 

[N, ~]= size(x1);
%append 1 to columns
%display(x1);
%display(x2);

%tempx = [x1(1,1),x1(1,2),1]';
%display(tempx);

%[x, y, 1]

minusOneArr = -1.*ones(N, 1);
zeroArr = zeros(N,3);
lastThreeRowA1 = zeroArr;
lastThreeRowA2 = zeroArr;
for i=1:N
    x = x1(i,1);
    y = x1(i,2);
    xdash = x2(i,1);
    ydash = x2(i,2);
    lastThreeRowA1(i,1) = x*xdash;
    lastThreeRowA1(i,2) = y*xdash;
    lastThreeRowA1(i,3) = xdash;
    lastThreeRowA2(i,1) = x*ydash;
    lastThreeRowA2(i,2) = y*ydash;
    lastThreeRowA2(i,3) = ydash;
    
end

A1 = [-1.*x1, minusOneArr, zeroArr, lastThreeRowA1]; %first row of A
A2 = [zeroArr, -1.*x1, minusOneArr, lastThreeRowA2]; %second row of A


A = [A1,A2]';
A = reshape(A(:),size(A1,2),[])';
[V,~] = eig(A'*A);
V= -1.*V;
H2to1= reshape(V(:,1), [3,3])';
%display(H2to1*tempx);
%display(H2to1);




end
