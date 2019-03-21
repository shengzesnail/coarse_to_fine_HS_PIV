function [u, v,fx, fy, ft] = HS_Estimation(im1, im2, lambda, ite, ...
    uLast,vLast, boundaryCondition)
%% Horn-Schunck optical flow method at a pyramid level
% Horn, B.K.P., and Schunck, B.G., Determining Optical Flow, AI(17), No.
% 1-3, August 1981, pp. 185-203 http://dspace.mit.edu/handle/1721.1/6337
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage:
% [u, v] = HS_Estimation(im1, im2, lambda, ite, uLast, vLast)
%
% -im1,im2 : two subsequent frames or images.
% -lambda : a parameter that reflects the influence of the smoothness term.
% -ite : number of iterations.
% -uLast, vLast : the flow field estimates of last pyramid; default is zero. 
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by Shengze Cai in March 2016
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Default parameters
if nargin<3
    lambda=1;
end
if nargin<4
    ite=200;
end
if nargin<7
    boundaryCondition = 'periodical';
end


%% Set initial value for the flow vectors
uInitial = uLast;
vInitial = uLast;
u = uInitial;
v = vInitial;

% Estimate spatiotemporal derivatives of images
[fx, fy, ft, fxy] = computeDerivatives_f(im1, im2, boundaryCondition);


% Averaging kernel
% kernel_1=[1/12 1/6 1/12;1/6 0 1/6;1/12 1/6 1/12];
kernel_1=[0 1/4 0;1/4 0 1/4;0 1/4 0];

estimation_method = 'HS';
% Iterations
for i=1:ite
    % Compute local averages of the flow vectors
    [uAvg] = computeAvg(u,kernel_1,boundaryCondition);
    [vAvg] = computeAvg(v,kernel_1,boundaryCondition);
    
    switch (estimation_method)
        case 'HS'
            Diffu = 0;
        % TE: transport equation is considered in the constraint
        case 'TE'       
            Diffu = - (1/Re/Sc)*fxy;
    end
    
    % Compute flow vectors constrained by its local average and the optical flow constraints
    data = ( fx .* (uAvg-uLast) ) + ( fy .* (vAvg-vLast) ) + ft + Diffu ;
    u= uAvg - ( fx .* ( data ) ) ...
        ./ ( lambda + fx.^2 + fy.^2); 
    v= vAvg - ( fy .* ( data ) ) ... 
        ./ ( lambda + fx.^2 + fy.^2);
end

u(isnan(u))=0;
v(isnan(v))=0;
