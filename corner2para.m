function [ para ] = corner2para( corners)

i = corners(4,:)-corners(2,:);
j = corners(1,:)-corners(2,:);
k = corners(6,:)-corners(2,:);


centre = mean(corners,1);

l = sqrt(sum((i).^2));
w = sqrt(sum((j).^2));
h = sqrt(sum((k).^2));

scale = [l w h];

i = i/norm(i);
j = j/norm(j);
k = k/norm(k);
if sqrt(sum((cross(i,j)+k).^2))<0.2 %ponder over this number 0.2 (2 or e-16)
    k = -k;
end

R = [i; j; k];
% orientation  = rad2deg(rpy(R)');
orientation = rpy(R)'*180/pi;

para = [centre scale orientation];
end

