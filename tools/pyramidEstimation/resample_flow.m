function out = resample_flow(uv, sz, method)
% function out = resample_flow(uv, factor, method)
%RESAMPLE_FLOW   Resample flow field
%   OUT = RESAMPLE_FLOW(IN, FACTOR[, METHOD]) resamples (resizes) the flow
%   field IN using a factor of FACTOR.  The optional argument METHOD
%   specifies the interpolation method ('bilinear' (default) or
%   'bicubic'). 
%  
%   This is a private member function of the class 'clg_2d_optical_flow'. 
%
%   Author:  Stefan Roth, Department of Computer Science, TU Darmstadt
%   Contact: sroth@cs.tu-darmstadt.de
%   $Date$
%   $Revision$

% Copyright 2004-2007 Brown University, Providence, RI.
% Copyright 2007-2008 TU Darmstadt, Darmstadt, Germany.
% 
%                         All Rights Reserved
% 
% Permission to use, copy, modify, and distribute this software and its
% documentation for any purpose other than its incorporation into a
% commercial product is hereby granted without fee, provided that the
% above copyright notice appear in all copies and that both that
% copyright notice and this permission notice appear in supporting
% documentation, and that the name of Brown University not be used in
% advertising or publicity pertaining to distribution of the software
% without specific, written prior permission.
% 
% BROWN UNIVERSITY DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
% INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY
% PARTICULAR PURPOSE.  IN NO EVENT SHALL BROWN UNIVERSITY BE LIABLE FOR
% ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
% ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
% OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

  
  % Make bilinear the default method
  if (nargin < 3)
    method = 'bilinear';
  end
%   
%   % Resize u and v 
%   tmp_u = ximresize(uv(:, :, 1), factor, method);
%   tmp_v = ximresize(uv(:, :, 2), factor, method);
%   out = cat(3, tmp_u, tmp_v)*factor;
%   
  ratio = sz(1) / size(uv,1);

%   if ratio < 1
%         % smoothing before downsampling
%         smooth_sigma  = 1/2/ratio;
%         f             = fspecial('gaussian', 2*round(1.5*smooth_sigma) +1, smooth_sigma);
%         uv    = imfilter(uv, f, 'corr', 'symmetric', 'same');
%   end;
  
  u     = imresize(uv(:,:,1), sz, method)*ratio;
  v     = imresize(uv(:,:,2), sz, method)*ratio;
  out   = cat(3, u, v);
  
