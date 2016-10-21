function [b] = isequalf(a, b, thresh)
%ISEQUALF  Returns true if the two quantities are equal within a threshold
%
%	t = ISEQUALF(A, B)
%	[t reason] = ISEQUALF(A, B, THRESH)
%
% This function is useful for floating point values, where there may be
% a small difference.
%
% See also: ISEQUAL.

% $Id: isequalf.m,v 1.1 2009-03-17 16:40:18 bradleyk Exp $
% Copyright (C) 2005, by Brad Kratochvil

if isa(a, 'sym') || isa(b, 'sym'),
  b = isequal(a,b);
else

  if 2 == nargin,
    thresh = eps()*100; % it's machine dependent now
  end

  m = max(abs(a-b));

  if any(m > thresh)
    b = false;
  else
    b = true;
  end

end