clc
clear all

load('Pts.mat')
X = points(:,1);
Y = points(:,2);
Z = points(:,3);

% n=2551; %2551 or 7064

FID = fopen('Box2.ply');
for i =1:13 %17 or 13
    tline = fgets(FID);
end

A = fscanf(FID,'%f');
fclose(FID);
x_num =  1:6:2551*6;
X = A(x_num);
Y = A(x_num+1);
Z = A(x_num+2);



%%
array = [5,6,8,7;3,4,8,7;1,2,4,3;1,2,6,5;2,4,8,6;1,3,7,5;];
num =0.1; % 0.1 or 0.005
score = 0;
i =0;
Finalscore = 0;
model = 0;
total = 0;
while (score<3300 && i<300)%% 
    [output, returnValue, temp,total_cuboids]  = minSet( X,Y,Z );
    total = total+total_cuboids;
    if output == 1
        s = size(returnValue);
        if numel(s)==2
            j = 1;
        else
            j = s(3);
        end
        for k = 1:j
            [answer] = PlotPlane( returnValue(:,:,k) ,0);
             para = corner2para(answer);
            [ sumOfdist, score , cset] = RansacScore(num,X,Y,Z,para );
            if score > 3000
                scatter3(X,Y,Z,5,'k');
                hold on
                PlotPlane( returnValue(:,:,k) ,1);
                scatter3(temp(:,1),temp(:,2),temp(:,3),'o','r');
                title(score);
                figure;
            end
            if score>Finalscore
                Finalscore = score;
                model = answer;
                Finalcset = cset;
                FinalPara = para;
                Finaltemp = temp;
                FinalsumOfdist = sumOfdist;
                Iteration = i;
            end
        end
    end
    i = i+1;
    if ~mod(i,100)
        disp(i);
    end
end
disp(i);

%% PLot Answer
% scatter3(X(Finalcset),Y(Finalcset),Z(Finalcset),5,'k'); %Plots only the consensus set.
scatter3(X,Y,Z,5,'k.');
title(Finalscore);
hold on
answer = model;
for j = 1:6
    u1 = array(j,:);
    B = answer(u1,:);
    fill3(B(:,1),B(:,2),B(:,3),'r');
    alpha 0.5
    hold on
    axis equal
end
numberss = '12345678';
for i = 1:8
text(answer(i,1),answer(i,2),answer(i,3),numberss(i));
end