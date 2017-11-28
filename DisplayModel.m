function [] = DisplayModel( points3D, Finalscore, model)
%CuboidRANSAC - Computes the best fitting cuboid on the 3D points using RANSAC. 
% If 90 percent points are in the consensus set or 300 iterations are
% reached, the code terminates and the current best is returned.
%
% Inputs: 
%    points3D - nx3 Matric containing the 3D points placed in rows.
%               points3D = [X, Y, Z]
%    model - 8x3 Matric containing the corners of the best-fit cuboid
%    Finalscore - Number of points in the consensus set.
%
% Outputs:
%    None
%
% Author: Usama Mehmood, Graduate Student, Stony Brook University, NY, US
% email address: umehmood@cs.stonybrook.edu 
% Website: https://usamamehmood.weebly.com
% Novemnber 2014; Last revision: 23-Nov-2017
%------------- BEGIN CODE --------------
X = points3D(:, 1);
Y = points3D(:, 2);
Z = points3D(:, 3);

array = [5,6,8,7;3,4,8,7;1,2,4,3;1,2,6,5;2,4,8,6;1,3,7,5;];
% scatter3(X(Finalcset),Y(Finalcset),Z(Finalcset),5,'k'); %Plots only the consensus set.
scatter3(X,Y,Z,5,'k','Marker', '.', 'SizeData', 100);
title(Finalscore);
hold on
for j = 1:6
    u1 = array(j,:);
    B = model(u1,:);
    fill3(B(:,1),B(:,2),B(:,3),'r');
    alpha 0.5
    hold on
    axis equal
end

numberss = '12345678';
for i = 1:8
    text(model(i,1),model(i,2),model(i,3),numberss(i));
end
end
%------------- END OF CODE --------------

