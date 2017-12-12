function [ answer ] = planePlot( b , flag )
%Solves for points of intersection of 6 planes.
%if flag = 1 then plot the six planes , if zero then do not plot.
answer = zeros(20,3);
normals = b(1:3,:);
normals = transpose(normals);
d = b(4,:);
Cmb =  combnk(1:6,3);
for i = 1:20;
    A = normals(Cmb(i,:),:);
    c = -d(Cmb(i,:));
    if abs(det(A))>0.005
        answer(i,:) = A\transpose(c);
    end
end

v1 = find(transpose(1:20).*(sum(answer,2)~=0));%non zero row #
% disp(v1);
answer = answer(v1,:);
if flag == 1
    Cmb = Cmb(v1,:);
    f = [1 2 4 3];
    cl = ['b','b','b','b','b','b'];
    for j = 1:6
        u1 = find(transpose(1:numel(Cmb)/3).*sum(Cmb==j,2));
        u1 = u1(f);
        B = answer(u1,:);
        fill3(B(:,1),B(:,2),B(:,3),cl(j));
        alpha 0.5
        hold on
        axis equal
    end
end

end

