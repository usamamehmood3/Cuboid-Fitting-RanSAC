function [model, CuboidParameters, inlierIndices, outlierIndices] = CuboidRANSAC( points3D )
%CuboidRANSAC - Computes the best fitting cuboid on the 3D points using RANSAC. 
% If 90 percent points are in the consensus set or 300 iterations are
% reached, the code terminates and the current best is returned.
%
% Inputs: 
%    points3D - nx3 Matric containing the 3D points placed in rows.
%               points3D = [X, Y, Z]
%
% Outputs:
%    model - 8x3 Matric containing the corners of the best-fit cuboid
%    CuboidParameters - 9x1 Matric containing the parameters of the best-fit.
%                Namely, centre, scale and orientation.
%                [centre_x centre_y centre_z length width height roll pitch yaw]
%    inlierIndicies - Linear indices of inlier points within the input point cloud,
%                returned as a column vector.
%    outlierIndices - Linear indices of outlier points within the input point cloud,
%                returned as a column vector.
%
% Author: Usama Mehmood, Graduate Student, Stony Brook University, NY, US
% email address: umehmood@cs.stonybrook.edu 
% Website: https://usamamehmood.weebly.com
% Novemnber 2014; Last revision: 23-Nov-2017
%------------- BEGIN CODE --------------
X = points3D(:, 1);
Y = points3D(:, 2);
Z = points3D(:, 3);

dia = sqrt((max(X) - min(X))^2 + (max(Y) - min(Y))^2 + (max(Z) - min(Z))^2);
num =dia/250; % Tolerance for consensus set.

scoreLimit = ceil(0.9 * size(X,1)); 
maxIterations = 1000;

score = 0;
i =0;
Finalscore = 0;
model = 0;
total = 0;
while (score < scoreLimit && i < maxIterations)
    [output, returnValue, ~, total_cuboids]  = minSet( X,Y,Z );
    total = total + total_cuboids;
    if output == 1
        s = size(returnValue);
        if numel(s) == 2
            j = 1;
        else
            j = s(3);
        end
        for k = 1:j
            [answer] = planePlot( returnValue(:,:,k) ,0);
             para = corner2para(answer);
            [ ~, score , cset] = RansacScore(num,X,Y,Z,para );
            if score>Finalscore
                Finalscore = score;
                model = answer;
                FinalPara = para;
                Finalcset = cset;
%                 Finaltemp = temp; %minimal set of points
%                 FinalsumOfdist = sumOfdist;
%                 Iteration = i;
            end
        end
    end
    i = i+1;
    if ~mod(i,100)
        disp(['Iterations completed: ', num2str(i)]);
    end
end
disp(['Total Iterations: ', num2str(i)]);
Indices = 1:numel(X);
inlierIndices = Indices(Finalcset)';
outlierIndices = Indices(~Finalcset)';
CuboidParameters = FinalPara;
end
%------------- END OF CODE --------------

