function [model,M, X, Y, Z, belements, bnodes] = mesh_gen(x,y,z)

[X,Y,Z]=meshgrid(x,y,z);
shp = alphaShape(X(:),Y(:),Z(:));
[belements,bnodes] = boundaryFacets(shp);%Creates a boundary mesh with triangular elements, see trisurf(belements,bnodes(:,1),bnodes(:,2),bnodes(:,3)) or  scatter3(bnodes(:,1),bnodes(:,2),bnodes(:,3));
bnodes = bnodes';
belements = belements';
model = createpde();
geometryFromMesh(model,bnodes,belements);% Imports geometry from boundary mesh into model 
generateMesh(model,'GeometricOrder','linear');% Creates internal mesh in the imported boundary geometry
%pdeplot3D(model);
[~,M,~,~,~,~,~] = assempde(model, 0, 1, 0);%a=1,c=0,f=0 in delc.delu +a.u=f 

end

