function plot_3d_surface(elem_nodes, coord, r)

faces = [
    elem_nodes(:,[1,2,3]);
    elem_nodes(:,[1,2,4]);
    elem_nodes(:,[1,3,4]);
    elem_nodes(:,[2,3,4])];
faces = sort(faces,2);

faces=sortrows(faces);
%[C,ia,ic]=unique(faces, 'rows')

nextiseq=(sum(abs(faces(2:end,:)-faces(1:end-1,:)),2)==0);
nextiseq = [nextiseq; false] | [false; nextiseq];
bndface = ~nextiseq;

bndnodes = faces(~nextiseq, :);
bndnodes = unique(bndnodes(:));

ind = false(max(elem_nodes(:)),1);
ind(bndnodes)=true;


faces = [
    elem_nodes(:,[1,2,3]);
    elem_nodes(:,[1,4,2]);
    elem_nodes(:,[2,4,3]);
    elem_nodes(:,[3,4,1])];
faces=faces(:,[2,1,3]);
bndfaces=all(ind(faces),2);

els = faces(bndfaces,:)';
pos = coord';
h=trisurf( els', pos(1,:), pos(2,:), pos(3,:), r );
shading interp
%lighting gouraud
%camlight
axis equal

