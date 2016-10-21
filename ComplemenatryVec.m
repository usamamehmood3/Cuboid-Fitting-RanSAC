function [ temp2 ] = ComplemenatryVec( vec, no )
a = zeros(1,no);
a(vec) = 1;
temp2 = find((1:no).*(1-a));
end

