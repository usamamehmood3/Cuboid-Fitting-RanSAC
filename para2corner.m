function [ corners ] = para2corner( para )

centre = para(1:3);
scale = para(4:6);
orientation= para(7:9);

a = orientation(1);b = orientation(2);c = orientation(3);

Rx = [1 0 0; 0 cosd(a) -sind(a);0 sind(a) cosd(a)];
Ry = [ cosd(b) 0 sind(b);0 1 0;-sind(b) 0 cosd(b)];
Rz = [ cosd(c) -sind(c) 0;sind(c) cosd(c) 0;0 0 1;];

R = Rz*Ry*Rx;

map = [-1,1,-1;-1,-1,-1;1,1,-1;1,-1,-1;-1,1,1;-1,-1,1;1,1,1;1,-1,1;];
corners = repmat(centre,8,1)+ map*( R.*( 0.5*repmat(scale',1,3) ) );
end

