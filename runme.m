clc
clear
close all

%% Load 3D point Data into columns X, Y, Z
% Box.mat and Box_other.mat have sample 3D point data.
dir = '3D Point Data/';
fname = 'Box.mat';
load([dir fname]);
%% RANSAC
[model, FinalPara, Finalscore] = CuboidRANSAC( X, Y, Z );
%% PLot Cuboid with the point cloud.
DisplayModel( X, Y, Z, Finalscore, model)



