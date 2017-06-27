%% Read image
% Remove all variables from workspace
clear;
% Clear command line window
clc;
% Read video from file
V = VideoReader('Robot-pushing 2 balls.avi');
% Get frames size
firstFrame = readFrame(V);
frameSize = size(firstFrame(:,:,1));

% Initialize vars
robotX = zeros(0,1);
robotY = zeros(0,1);
whiteBack = zeros(frameSize);
whiteBack = whiteBack + 255;

V.CurrentTime = 0;
while hasFrame(V)
    iFrame = readFrame(V);
    % Get binarize image specific just including the robot
    iBin = BinarizeRobot(iFrame);
    % Append new coordinates to arrays
    [robotX(end + 1),robotY(end + 1)] = GetObjectCoordinates(iBin);
    % Didactic printing
    pause(1/V.FrameRate);
    imshow(iBin)
end

% Print white background and position
% imshow(whiteBack);
hold on
plot(robotX,robotY, 'b-');
hold off