function [output, returnValue, temp, total_cuboids] = minSet( X,Y,Z )
% output is a flag for a valid minset, returnValue contains 6 planes (6x4xi)
% (cuboid) fit in the minimal set, temp contains min set.
% total_cuboids = total cuboids fitted in the min. set.
returnValue = zeros(4,6,1);
output = 0;
answerNo = 0;
no =9;
indices = 1:no;
finalResult = zeros(4,6);
% pnts = randi(numel(X),no,1);
pnts=transpose(randperm(numel(X),no));
temp = [X(pnts),Y(pnts),Z(pnts)];
Cmb = combnk(1:no,3);
O = ones(no,1);
no1 = nchoosek(no,3);
rslt = zeros(no1,1);

%Finds Convex Hull of 9 points such that rest of the points are on one side.
for i = 1:no1
    temp1 = temp(Cmb(i,1),:);
    temp2 = temp(Cmb(i,2),:);
    temp3 = temp(Cmb(i,3),:);
    n = cross((temp2-temp1),(temp3-temp1));
    if norm(n) == 0
        rslt(i) = no-5;
        continue;
    end
    n = n/norm(n);
    d = dot(temp1,n);
    d=round(d*10^4)/10^4;
    t = O*n;
    t1 = sum(temp.*t,2);
    t1=round(t1*10^4)/10^4;
    a = t1<d; %no of points that are under under the plane (on the side of origin)
    c = sum(a);
    rslt(i) = c;
end


% disp(sum(rslt ==(no-3))+sum(rslt ==0));

v = (rslt==(no-3)) | (rslt==0);
indices2 = 1:numel(v);
v1 = indices2(v); %Legitimate planes

num = numel(v1); %number of legitimate planes
distMax1 = zeros(1,num);
planes  = zeros(4,num);
rslt1 = zeros(num,nchoosek(no-3,2));
%Finds point that is max d away from every plane.
for i = 1:num
    temp1 = temp(Cmb(v1(i),1),:);
    temp2 = temp(Cmb(v1(i),2),:);
    temp3 = temp(Cmb(v1(i),3),:);
    n = cross((temp2-temp1),(temp3-temp1));% normal Plane1
    if norm(n) == 0
        continue;
    end
    n = n/norm(n);
    d = dot(temp1,n);
    d=round(d*10^4)/10^4;
    planes(:,i) = transpose([n -d]);
    %     C = [-n(1)/n(3) -n(2)/n(3) d/n(3)];
    C = [n -d];
    [~, dz] = dist2plane(temp,C);
    A1 =  indices((dz-max(dz))==0);
    distMax1(i) = A1(1);
    n2 = n;
    d2 = dot(n2, temp(distMax1(i),:));
    
    vec = Cmb((v1(i)),:);
    Rem = ComplemenatryVec( vec, no );
    CmbRem = combnk(Rem,2); %% All size 2 combinations of remaining 6 points
    
    %To find a plane2(Contains 2 points) perpendicular to plane1
    for k = 1:numel(CmbRem)/2
        vec1 = CmbRem(k,:);
        n1 = cross(n,( temp(vec1(1),:)-temp(vec1(2),:) ) ); % normal Plane2
        if norm(n1) == 0
            continue;
        end
        n1 = n1/norm(n1);
        d1 = dot(n1,temp(vec1(1),:));
        d1=round(d1*10^4)/10^4;
        t = O*n1;
        t1 = sum(temp.*t,2);
        t1=round(t1*10^4)/10^4;
        a = t1<d1;
        c = sum(a);
        rslt1(i,k) = c;
        if c==0 || c==(no-2) % for legitimate planes go on to fit the cuboid
            finalResult(:,1) = planes(:,i);%1
            finalResult(:,2) = transpose([n1 -d1]);%2
            finalResult(:,3) = transpose([n2 -d2]);%3
            
            %             C = [-n1(1)/n1(3) -n1(2)/n1(3) d1/n1(3)];
            C = [n1 -d1];
            [projections, dz] = dist2plane(temp,C);
%             if numel(temp( indices( (dz-max(dz))==0),:)) ~= 3
%                 temp( indices( (dz-max(dz))==0),:)
%                 dz
%                 C
%                 CmbRem
%                 n1temp
%                 n1
%                 k
%             end
            A2 = indices( (dz-max(dz))==0 );
            d3 = dot(n1, temp( A2(1) ,:) ) ;
            finalResult(:,4) = transpose([n1 -d3]);%4
            
            n4 = cross(n,n1);
            n4 = n4/norm(n4);
            t = O*n4;
            qwerty = sum(projections.*t,2);
            Amin = indices( ( qwerty - min(qwerty) )==0);
            minNum = Amin(1);
            Amax = indices( ( qwerty - max(qwerty) )==0);
            maxNum = Amax(1);
            d4 = dot( n4,temp(minNum,:) );
            d5 = dot( n4,temp(maxNum,:) );
            finalResult(:,5) = transpose([n4 -d4]);%5
            finalResult(:,6) = transpose([n4 -d5]);%6
            %To see how many points are used in the cuboid
            vector1 = [Cmb(v1(i),:) CmbRem(k,:) distMax1(i) minNum maxNum A2(1) ];
            nps = numel(ComplemenatryVec(vector1,no));
            
            if nps == 0
                %             scatter3(temp(:,1),temp(:,2),temp(:,3),'k','o');
                answerNo = answerNo+1;
                hold on
                output =1;
                %             PlotPlane( finalResult,0); % Plot final result.
                returnValue(:,:,answerNo) = finalResult;
            end
        end
    end
    
    
    
end
total_cuboids = sum(sum((rslt1==0) + (rslt1==no-2)));
% disp(total_cuboids);
% disp(rslt1); % Rows are plane1 number, Columns show legitimate plane2
end

