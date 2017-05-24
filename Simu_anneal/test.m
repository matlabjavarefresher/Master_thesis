function test(varargin)
% TEST Short description of test.
%   TEST(VARARGIN) Long description of test.
%
% Example (<a href="matlab:run_example test">run</a>)
%
% See also

%   <author>
%   Copyright 2017, <institution>
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version. 
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.

for i=1:100
    A=rand(i);
    inv(A);
end

for i=1:100
    A=rand(i);
    eig(A);
end

