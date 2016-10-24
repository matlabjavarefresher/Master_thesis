
clear
clf

%% optional settings

correlation_type={'gaussian', 'exponential', 'matern', 'spec_func'};
correlation_type=correlation_type{2};% for expo coveriance
nu=1;
% for first three
L_c=0.1;
sigma=1;

% params for the spe func (damped oscillatory correlation function)
% Amplitude
    A = 1.0040;
% damping coeff
    alpha = 0.0147;
% frequency
    omega =0.0157;
% phase shift
    phi = -11.1833;
    n_refine=3;
%% setup mesh

x=[1:50];
y=[1:50];
z=[1:10];
[model,G, X, Y, Z, belements, bnodes] = mesh_gen(x,y,z);
coord=model.Mesh.Nodes;
elem_nodes=model.Mesh.Elements;


%% Field properties

switch correlation_type
    case 'gaussian'
        cov_func=@(d)( reshape(gaussian_covariance( d(:)', [], L_c, sigma), size(d) ) );
    case 'exponential'
        cov_func=@(d)( reshape(exponential_covariance( d(:)', [], L_c, sigma), size(d) ) );
    case 'matern'
        cov_func=@(d)( reshape(matern_covariance(nu, d(:)', [], L_c, sigma), size(d) ) );
    case 'spec_func'
        cov_func=@(d)( reshape(spec_cov_func( d(:)', A, alpha, omega, phi), size(d) ) );
end
%% Represent a Gaussian random field
D=dist(coord);
C = cov_func(D);
N = size(coord, 2);

% Compute the KL expansion
L = min(1000, N-1);
[r_i_k, lambda_k] = kl_solve_evp(C, G, L);%G here is the mass matrix
sigma_k=sqrt(lambda_k);
display(strvarexpand('The represented varince is $sum(sigma_k.^2)*100$%'));

% Setup the multiindex for m = L Gaussian random variables
m = L;
I = multiindex(m, 1);


% The corresponding coefficients have 
k = 1:m;
theta_k_alpha = zeros(L,m+1);
theta_k_alpha(k,k+1) = eye(m);

% Convert to compact form and include mean
% [u2_i_k, theta2_k_alpha] = kl_pce_to_compact_form(sin(pi*x'), r_i_k, sigma_k, theta_k_alpha);

% The conversion made explicit
% a) Multiply in the sigmas 
u_i_k = binfun(@times, r_i_k, sigma_k);

% b) Put the mean inside
u_mean=zeros(N, 1);
u_i_k = [u_mean, u_i_k];
theta_k_alpha = [1, zeros(1,m); theta_k_alpha];


% Generate some normally distributed random numbers for plotting some
% realisations of the random field
xi = randn(m, 1);
clf
r=kl_pce_field_realization(u_i_k, theta_k_alpha, I, xi);

%plot field
subplot(2,1,1)
pdeplot3D(model, 'ColorMap', r);

%% define excursion set
%Level set
kappa=0.5;
rb=r;
excur_ind=rb>kappa;
rb(~excur_ind)=0;
rb(excur_ind)=1;
% plot binary r
subplot(2,1, 2)
pdeplot3D(model, 'ColorMap', rb);
%plot_3d_surface(elem_nodes, coord, rb)

%%
% Make the same plot, but now with the meshgrid on the boundary
[p,e,t] = meshToPet(model.Mesh);
F = pdeInterpolant(p,t,r);
r_bound = evaluate(F,bnodes(1,:),bnodes(2,:),bnodes(3,:));
% figure
% h=trisurf(belements, bnodes(1,:),bnodes(2,:),bnodes(3,:),r_bound) % check
%%
% here we should create new X, Y and Z
R = evaluate(F,X(:),Y(:),Z(:));
R=reshape(R, size(X));
figure
p = patch(isosurface(X,Y,Z,R,kappa));
isonormals(X,Y,Z,R,p)
p.FaceColor = [0.6,0.6,0.6];
p.EdgeColor = 'none';
daspect([1,1,1])
view(3); axis tight
camlight 
lighting gouraud

%% Plotting the solution r

r_meshed = evaluate(F,X(:),Y(:),Z(:));
r_fin=reshape(r_meshed,50,50,10);
surf(X,Y,Z,r_fin);


