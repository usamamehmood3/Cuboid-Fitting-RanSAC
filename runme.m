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
[model, FinalPara, Finalscore] = CuboidRANSAC( points3D );
%% PLot Cuboid with the point cloud.
DisplayModel(points3D, Finalscore, model);



