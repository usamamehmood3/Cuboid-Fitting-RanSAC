clc
clear
close all

%% Load 3D point Data into columns X, Y, Z
% Box.mat and Box_other.mat have sample 3D point data.
dir = '3D Point Data/';
fname = 'Box.mat';
load([dir fname]);

points3D = [X Y Z];


%% RANSAC
[model, CuboidParameters, inlierIndices, outlierIndices] = CuboidRANSAC( points3D );

%% PLot Cuboid with the point cloud where inliers are colored blue, and outliers red.
scatter3(X(inlierIndices), Y(inlierIndices), Z(inlierIndices),...
    5, 'b', 'Marker', '.', 'SizeData', 100);
scatter3(X(outlierIndices), Y(outlierIndices), Z(outlierIndices),...
    5, 'r', 'Marker', '.', 'SizeData', 100);
DisplayModel(numel(inlierIndices), model);



