function [pp, dz] = dist2plane( po,para )
% Author: Usama Mehmood, Graduate Student, Stony Brook University, NY, US
% email address: umehmood@cs.stonybrook.edu 
% Website: https://usamamehmood.weebly.com
% November 2014; Last revision: 23-Nov-2017
%
% Copyright (C) 2014, by Usama Mehmood
% Work done under supervision of Dr. Sohaib Ahmad Khan 
%%

s = size(po);
rows = s(1);
n = para(1:3);
d = -para(4);

dz = abs(dot(po',repmat(n',1,rows)) - d);
dz = dz';
map = dz<=d;
map = map + -1*(~map);
pp = po + repmat(dz.*map,1,3).*repmat(n,rows,1);


dz = dz';
end


