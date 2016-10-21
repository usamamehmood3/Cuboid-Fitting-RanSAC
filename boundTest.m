function [result] = boundTest(X,Y,Z,pp,corners)
%corner: four 3d corners of a rectangle 4x3
d1 = corners(1,:)-corners(2,:);
d2 = corners(3,:)-corners(2,:);

po = [X,Y,Z];
d1 = d1/norm(d1);
d2 = d2/norm(d2);


A = sum(pp.*repmat(d1,numel(X),1),2);
B = sum(pp.*repmat(d2,numel(X),1),2);
l1 = min(dot(d1,corners(1,:)),dot(d1,corners(2,:)));
l2 = max(dot(d1,corners(1,:)),dot(d1,corners(2,:)));
l3 = min(dot(d2,corners(3,:)),dot(d2,corners(2,:)));
l4 = max(dot(d2,corners(3,:)),dot(d2,corners(2,:)));
result = A<l2 & A>l1 & B<l4 & B>l3;
%% PLOTTING
% pp = pp( find(transpose(1:numel(X)).*result) , :); % only on rectange
% %PLOTTING
% scatter3(po(:,1),po(:,2),po(:,3),2,'k');
% hold on
% scatter3(pp(:,1),pp(:,2),pp(:,3),2,'b');
% % hold on
% fill3(corners(:,1),corners(:,2),corners(:,3),'r');
% alpha 0.3
% axis equal
end

