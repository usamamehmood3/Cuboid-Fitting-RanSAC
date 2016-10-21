function [pp, dz] = dist2plane( po,para )


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


