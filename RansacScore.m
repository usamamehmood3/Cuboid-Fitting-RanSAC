function [sumOfdist, score , cset] = RansacScore(num,X,Y,Z,para )
answer = para2corner(para);
array = [5,6,8,7;3,4,8,7;1,2,4,3;1,2,6,5;2,4,8,6;1,3,7,5;];
po = [X,Y,Z];
score = 0;
indices = 1:numel(X);
cset = zeros(numel(X),1);
sumOfdist = 0;
for i = 1:6
    corners = answer(array(i,:),:);
    d1 = corners(1,:)-corners(2,:);
    d2 = corners(3,:)-corners(2,:);
    n = cross(d1,d2);% normal
    n = n/norm(n);
    d = dot( corners(1,:),n);
    d=round(d*10^4)/10^4;
    C = [n -d];
    
    [pp, dz] = dist2plane(po,C);
    sumOfdist = sumOfdist + sum(dz(dz<3*num));
    
    [result] = boundTest(X,Y,Z,pp,corners);
    cset = cset | (result & (dz<num)');
    dz = dz( indices(result) );
    score = sum(cset);
end
% cset = indices(cset);
%     score = sum(cset);

end

