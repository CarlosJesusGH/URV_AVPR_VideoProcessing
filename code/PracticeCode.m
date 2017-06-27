%% Read image
% Remove all variables from workspace
clear;
% Clear command line window
clc;
% Read video from file
V = VideoReader('Robot-pushing 2 balls.avi');
% Read image from file
I = imread('sample-image.bmp');

% Initialize vars
robotX = zeros(0,1);
robotY = zeros(0,1);
whiteBack = zeros(size(I(:,:,1)));
whiteBack = whiteBack + 255;

V.CurrentTime = 0;
while hasFrame(V)
    iFrame = readFrame(V);
    iBin = BinarizeRobot(iFrame);
    [robotX(end + 1),robotY(end + 1)] = GetObjectCoordinates(iBin);
%     pause(1/V.FrameRate);
    imshow(iBin)
end

% Print white background and position
% imshow(whiteBack);
hold on
plot(robotX,robotY, 'b-');
hold off


%% -------------------------------------------------------
%% Write image to work with
V = VideoReader('Robot-pushing 2 balls.avi');
V.CurrentTime = 3;
iFrame = readFrame(V);
imwrite(iFrame,'sample-image.bmp');

%% Create gray level from image and remove background
% Create gray level image
pauseRate = 1;
I = imread('sample-image.bmp');
Igray = rgb2gray(I);
redChan = I(:,:,1);
greenChan = I(:,:,2);
imshow(redChan);
pause(pauseRate);
% Remove white background to image
Inb_mask = imbinarize(redChan, 0.25);
imshow(Inb_mask);
pause(pauseRate);
% Inb_mask = imcomplement(Inb_mask);
green_nb = greenChan;
green_nb(Inb_mask) = 0;
imshow(green_nb);
pause(pauseRate);
green_bin = imbinarize(green_nb, 0.40);
% Morphological filter - Open, then dilate.
se = strel('square', 3);
green_bin = imopen(green_bin, se);
se2 = strel('disk', 8);
green_bin = imdilate(green_bin, se2);
imshow(green_bin)
% Finding object centroid
s = regionprops(green_bin, 'Centroid');
centroids = cat(1, s.Centroid);


% imshow(I);
hold on
plot(centroids(:,1),centroids(:,2), 'b*')
hold off
% figure;
% imhist(green_nb);

%% RGB color space
% Separate 3 channels
redChan = I(:,:,1);
greenChan = I(:,:,2);
blueChan = I(:,:,3);
% Show 3 channels
figure;
subplot(2,2,1), imshow(redChan);
title('Red plane');
subplot(2,2,2), imshow(greenChan);
title('Green plane');
subplot(2,2,3), imshow(blueChan);
title('Blue plane');
subplot(2,2,4), imshow(I);
title('Original plane');



%% Separating green color using green channel
imhist(greenChan);
figure;
imshow(greenChan);


%% HSV color space
% Transform image from RGB to HSV
Ihsv = rgb2hsv(I);
% Separate 3 channels
hmat = Ihsv(:,:,1);
smat = Ihsv(:,:,2);
vmat = Ihsv(:,:,3);

% Show 3 channels
figure;
subplot(2,2,1), imshow(hmat);
title('Hue plane');
subplot(2,2,2), imshow(smat);
title('Satturation plane');
subplot(2,2,3), imshow(vmat);
title('Value plane');
subplot(2,2,4), imshow(Ihsv);
title('Original plane');

%% Better look on HSV space
% Show hue channel alone
figure;
imshow(hmat);

% Show histogram for hue channel
figure;
imhist(hmat);

imtool(hmat);

%% Stretch out the hue image
% Find limits in image
limitValues = stretchlim(hmat)
% Stretch image out
imHueStretch = imadjust(hmat, limitValues);
% Compare histograms
imshowpair(hmat, imHueStretch, 'montage'); 
figure;
% imshowpair(imhist(hmat), imhist(imHueStretch), 'montage');
imhist(hmat)
figure;
imhist(imHueStretch)
% Check values for pixels in stretched out image
imtool(imHueStretch);

%% Apply threshold to HSV image
t1 = 0.39; 
t2 = 0.51;
Ithresh = imHueStretch;
Ithresh(imHueStretch > t1 & imHueStretch < t2) = 255;
imshow(Ithresh);
% (hImage >= hueThresholdLow) & (hImage <= hueThresholdHigh);
% Ithresh(find(Ithresh > t1 & Ithresh <= t2)) = 0;
% Ithresh(find(Ithresh < t1 & Ithresh >= t2)) = 255;

% imbinarize(hmat, T);
% imshow(Ithresh);




%% LAB color space
% Transform image from RGB to LAB
Ilab = rgb2lab(I);
% Separate 3 channels
lmat = Ilab(:,:,1);
amat = Ilab(:,:,2);
bmat = Ilab(:,:,3);

% Show 3 channels
figure;
subplot(2,2,1), imshow(lmat);
title('L plane');
subplot(2,2,2), imshow(amat);
title('A plane');
subplot(2,2,3), imshow(bmat);
title('B plane');
subplot(2,2,4), imshow(I);
title('Original plane');




%% Other things for later

%% Read image

%% RGB color space
rmat = I(:,:,1);
gmat = I(:,:,2);
bmat = I(:,:,3);

figure;
subplot(2,2,1), imshow(rmat);
title('Red plane');
subplot(2,2,2), imshow(gmat);
title('Green plane');
subplot(2,2,3), imshow(bmat);
title('Blue plane');
subplot(2,2,4), imshow(I);
title('Original plane');

% Show image histogram
imhist(I);

% Complement image (black background white objects)
Icomp = imcomplement(Isum);

% Fill the holes
Ifilled = imfill(Icomp, 'holes');

% Morphological filter - Open / Using structuring element
se = strel('square', 25);
Iopenned = imopen(Ifilled, se);

% Transform image from RGB to gray levels
Igray = rgb2gray(I);

% Binarize image using level
level = 0.5;
Ithresh = im2bw(Igray, level);

% Double threshold
t1 = 50; t2 = 100;
im(find(im > t1 && im <= t2)) = 0;
im(find(im < t1 && im >= t2)) = 255;

% Stretch out image histogram
stretchlim(hmat)
imHueStretch = imadjust(hmat, stretchlim(hmat));

%% Other sample codes

% iml = readFrame(v);
% imshow( iml );
% imwrite(iml,'clockFrame1.bmp');


% i = 0;
% while hasFrame(v)
%     video = readFrame(v);
%     i = i + 1
% end
% whos video

% implay('Robot-pushing 2 balls.avi') 

% aviinfo('Robot-pushing 2 balls.avi')

% I = imread('Robot-pushing 2 balls.avi');
% sequence = zeros([size(I) numFrames],class(I));
% sequence(:,:,1) = I;
% %
% for p = 2:numFrames
%     sequence(:,:,p) = imread(fileNames{p}); 
% end

% READ THE AVI

% mov=aviread('Robot-pushing 2 balls.avi');

% GRAB A SINGLE FRAME

% [im1,map] = frame2im(mov(1));

% SHOW THE FRAME

% imshow( im1 );

% SET THE COLORMAP PROPERLY SO THE IMAGE SHOWS CORRECTLY

% colormap( map );

% WRITE OUT THE FRAME TO A BMP FILE

% imwrite(im1,map,'clockFrame1.bmp');


