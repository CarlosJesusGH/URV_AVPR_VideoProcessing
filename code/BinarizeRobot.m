function iBin = BinarizeRobot( iOri )
%BINARIZEROBOT Summary of this function goes here
%   Detailed explanation goes here
% Create gray level image
Igray = rgb2gray(iOri);
redChan = iOri(:,:,1);
greenChan = iOri(:,:,2);
% imshow(Igray);
% Remove white background to image
% Inb_mask = imbinarize(redChan, 0.35);
Inb_mask = imbinarize(redChan, 0.25);
% Inb_mask = imcomplement(Inb_mask);
green_nb = greenChan;
% Mask image so only remain main object
green_nb(Inb_mask) = 0;
% Binarize no-background image (working on green channel)
% green_bin = imbinarize(green_nb, 0.38);
green_bin = imbinarize(green_nb, 0.40);

% Morphological filter - Open
se = strel('square', 3);
green_bin = imopen(green_bin, se);
% Morphological filter - Dilate
se2 = strel('disk', 8);
green_bin = imdilate(green_bin, se2);
% Return result
iBin = green_bin;
end

