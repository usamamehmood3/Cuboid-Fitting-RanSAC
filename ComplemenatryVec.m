function [ temp2 ] = ComplemenatryVec( vec, no )
% Author: Usama Mehmood, Graduate Student, Stony Brook University, NY, US
% email address: umehmood@cs.stonybrook.edu 
% Website: https://usamamehmood.weebly.com
% November 2014; Last revision: 23-Nov-2017
%
% Copyright (C) 2014, by Usama Mehmood
% Work done under supervision of Dr. Sohaib Ahmad Khan 
%%
a = zeros(1,no);
a(vec) = 1;
temp2 = find((1:no).*(1-a));
end

