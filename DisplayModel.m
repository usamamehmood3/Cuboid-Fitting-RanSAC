function [] = DisplayModel( Finalscore, model)
%CuboidRANSAC - Computes the best fitting cuboid on the 3D points using RANSAC. 
% If 90 percent points are in the consensus set or 300 iterations are
% reached, the code terminates and the current best is returned.
%
% Inputs: 
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
array = [5,6,8,7;3,4,8,7;1,2,4,3;1,2,6,5;2,4,8,6;1,3,7,5;];
title(Finalscore);
hold on
for j = 1:6
    u1 = array(j,:);
    B = model(u1,:);
    fill3(B(:,1),B(:,2),B(:,3),'r');
    alpha 0.2
    hold on
    axis equal
end

numberss = '12345678';
for i = 1:8
    text(model(i,1),model(i,2),model(i,3),numberss(i));
end
end
%------------- END OF CODE --------------

