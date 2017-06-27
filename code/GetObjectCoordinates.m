function [ x,y ] = GetObjectCoordinates( iBin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Finding object centroid
s = regionprops(iBin, 'Centroid');
centroids = cat(1, s.Centroid);
x = centroids(:,1);
y = centroids(:,2);
end

