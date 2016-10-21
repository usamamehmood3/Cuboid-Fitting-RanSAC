clc
savedPara = FinalPara;
hybridopts = optimset('TolX',1e-8,'TolFun',1e-10,'MaxFunEvals',2000);

% savedPara(1) = savedPara(1)+0.005;
% savedPara(2) = savedPara(2)+10;
% savedPara(7) = savedPara(7)+5;

[x, a, b, c,d] = fminunc(@(savedPara)RansacScore(num,X(Finalcset),Y(Finalcset),...
    Z(Finalcset),savedPara),savedPara,hybridopts);
% [x, a, b, c,d] = fminunc(@(FinalPara)RansacScore(0.1,Finaltemp(:,1),Finaltemp(:,2),...
%     Finaltemp(:,3),FinalPara),FinalPara,hybridopts);

disp(savedPara - x);

disp(['Before: ' num2str(RansacScore(num,X(Finalcset),Y(Finalcset),...
    Z(Finalcset),savedPara)) '    After: ' num2str(a)]);

optimCorner = para2corner(x);
hold on
for j = 1:6
    u1 = array(j,:);
    B = optimCorner(u1,:);
    fill3(B(:,1),B(:,2),B(:,3),'b');
    alpha 0.5
    hold on
    axis equal
end
