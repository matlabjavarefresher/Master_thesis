function [do_add] = allow_absolute_overlap(im1, im2, res, A_limit)
% ALLOW_ABSOLUTE_OVERLAP Limits absolute overlap between shapes.
%   [DO_ADD] = ALLOW_ABSOLUTE_OVERLAP(IM1, IM2, RES, A_LIMIT) will allow IM2
%   to be added to IM1 in case the overlap (scalar product) between IM1 and
%   IM2 does not exceed A_LIMIT.
%
% Example (<a href="matlab:run_example allow_absolute_overlap">run</a>)
%
% See also

%   Elmar Zander
%   Copyright 2017, Inst. of Scientific Computing, TU Braunschweig
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version. 
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.




% Here the term absolute means that the computation of the overlap extent
% below is based only on the scalar product of im1 and im2 and it is not
% relative (i.e. the product is not divided by the number of those elements
% in the intersection region of im1 and im2 with values greater than 0)

im = im1 .* im2;
A = sum(im(:)) / res^(ndims(im));
A
do_add = A < A_limit;

% % ovlp_extent0=sum(sum(im))/numel(im);
% % ovlp_extent1=sum(sum(im))/numel(im>0);
%
%  ovlp_extent2=sum(sum(im==0))/numel(im);
%
%  ovlp_extent3=sum(sum(im1(im1 & im2)))/numel(im1(im1 & im2)>0);
%
% % ad = ovlp_extent1<ovlp;
%
% ad=(1-ovlp_extent2)<ovlp & (ovlp_extent3 <ovlp);

end