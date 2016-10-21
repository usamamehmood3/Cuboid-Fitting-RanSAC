function [out, varargout] = isrot(r)
%ISROT  returns true if the matrix is a rotation matrix
%
%	T = ISROT(R)
%	[T REASON] = ISTROT(R)
%
% if REASON is supplied as an output, a text based message as to why the
% test failed will be returned.
%
% See also: ISTWIST, ISSKEW, ISHOM.

% $Id: isrot.m,v 1.1 2009-03-17 16:40:18 bradleyk Exp $
% Copyright (C) 2005, by Brad Kratochvil

  global DebugLevel;

  out = true;
  varargout = {'rot'};
  
  if ~isequal([3 3], size(r)),
    out = false;
    varargout = {'matrix must be 3x3'};
    return;
  end
  
  if (isempty(DebugLevel)) || (DebugLevel > 1)
    
    if ~isequalf(eye(3), r' * r, 1e-12),
      out = false;
      varargout = {'transpose(r) * r = I violated'};
      return;
    end

    if ~isequalf(1, det(r)),
      out = false;
      varargout = {'det(r) == 1 violated'};
      return;
    end
  
  end
  
end