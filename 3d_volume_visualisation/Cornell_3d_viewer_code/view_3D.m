%% This work was performed for Nichole VanderSal at Cornell

function view_3D(shape)
%patch smoothing factor
rfactor = 0.125; 
%isosurface size adjustment
level = .8;
%useful string constants
c2 = 'facecolor';
c1 = 'edgecolor';

%build one isosurface for each of 7 different levels
%The "shape" matrix takes on one of 7 integer values,
%so each of the following converts the data to a binary
%volume variable, then computes the isosurface between the
%1 and 0 regions

p=patch(isosurface(smooth3(shape==1),level));
reducepatch(p,rfactor)
set(p,c2,[1,0,0],c1,'none');

p=patch(isosurface(smooth3(shape==2),level));
reducepatch(p,rfactor)
set(p,c2,[0,1,0],c1,'none');

p=patch(isosurface(smooth3(shape==3),level));
reducepatch(p,rfactor)
set(p,c2,[1,1,0],c1,'none');

p=patch(isosurface(smooth3(shape==4),level));
reducepatch(p,rfactor)
set(p,c2,[0,0,1],c1,'none');

p=patch(isosurface(smooth3(shape==5),level));
reducepatch(p,rfactor)
set(p,c2,[1,0,1],c1,'none');

p=patch(isosurface(smooth3(shape==6),level));
reducepatch(p,rfactor)
set(p,c2,[0,1,1],c1,'none');

p=patch(isosurface(smooth3(shape==7),level));
reducepatch(p,rfactor)
set(p,c2,0.8*[1,1,1],c1,'none');

%lighting/image control
set(gca,'projection','perspective')
box on
lighting phong
light('position',[1,1,1])
light('position',[-1,-1,-1])
light('position',[-1, 1,-1])
light('position',[ 1,-1,-1])

%set relative proportions
daspect([1,1,1])
axis on
set(gca,'color',[1,1,1]*.6)

view(-30,30)

rotate3d on

end