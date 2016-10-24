function [X, Y, Z, V, reshape_func]=sort_structured_mesh_coord_to_meshgrid(coord, v)

% takes as input COORD =[x,y,z], where x, y and z are vectors with the
% coordinates, and structures them in a meshgrid
N=size(coord,1);
% dimension
d=size(coord,2);

% check if grid is really structured
n=zeros(1,d);
for i=1:d
    n(i)=length(unique(coord(:,i)));
end

check_boolean(prod(n)==N, 'meshnodes can not be structured to meshgrid format');

% sort meshnodes
%   -flip, sort and flip back
[~,index] = sortrows(fliplr(coord));

% new sorted coordinate vectors

X=tomeshgrid(coord(:,1), n, index);
Y=tomeshgrid(coord(:,2), n, index);
if d>2
    Z=tomeshgrid(coord(:,3), n, index);
end

if nargin>1
    V=reshape(v(index), n);
end
if nargout>4
    reshape_func=@(v)tomeshgrid(v, n, index);
end

end
function X=tomeshgrid(x, n, index)
if n==2
    X=permute(reshape(x(index), n) , [2,1]);
else
    X=permute(reshape(x(index), n) , [2,1,3]);
end
end