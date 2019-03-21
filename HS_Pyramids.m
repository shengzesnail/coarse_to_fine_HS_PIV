% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Horn-Schunck Motion Estimation Using Multi-Pyramids (Multi-Resolution)
% Ref:	
%   Ruhnau, P., et al. (2005) Experiments in Fluids 38(1):21-32.
%   Heitz, D., et al. (2010) Experiments in Fluids, 48(3):369-393.
%   Sun, D., et al. (2010). Computer Vision & Pattern Recognition.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage: [u, v] = HS_Pyramids(img1,img2,lambda,PARA)
% ********** inputs ***********
%   im1,im2: two subsequent frames or images.
%   lambda: a parameter that reflects the influence of the smoothness term.
%   PARA: parameters
% ********** outputs ************
%   u, v: the velocity components
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Shengze Cai, 2016/03
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%% main function %%%%%%%%%%%%
function [u, v] = HS_Pyramids(img1,img2,lambda,PARA,uvInitial)
% Initialize the velocity field
if nargin<5
    uInitial=zeros(size(img1));
    vInitial=zeros(size(img1));
    uvInitial = cat(3,uInitial,vInitial);
end
% Read original images and transform to grey images
if size(size(img1),2)==3
    img1=rgb2gray(img1);
end
if size(size(img2),2)==3
    img2=rgb2gray(img2);
end
img1=double(img1);
img2=double(img2);
% Run HS with multi-pyramids
[u, v] = Estimate(img1, img2, lambda, uvInitial,PARA);


%% Run Horn-Schunck on all levels and interpolate %%  
function [Dx, Dy] = Estimate(img1, img2, lambda,uvInitial,PARA)
warp_iter = PARA.warp_iter;
sizeOfMF = PARA.sizeOfMF;
isMedianFilter = PARA.isMedianFilter; 
Dx = uvInitial(:,:,1); 
Dy = uvInitial(:,:,2);

%% Construct image pyramid for gnc stage 1
pyramid_level = PARA.pyramid_level;
G1{1} = img1; G2{1} = img2;
for L = 2:pyramid_level           
    % Downsampling
    G1{L} = reduce2 (G1{L-1});                           
    G2{L} = reduce2 (G2{L-1});   
end;

%% iteration
level = pyramid_level;
for current_level=level:-1:1 
    disp(['-Pyramid level: ', num2str(current_level)])

    small_img1 = G1{current_level};
    small_img2 = G2{current_level};
    sz = size(small_img1);

    uv =  resample_flow(cat(3,Dx,Dy), sz);
    Dx = uv(:,:,1); Dy = uv(:,:,2);

    for iwarp = 1:warp_iter
        W1 = warp_forward (small_img1, Dx, Dy, PARA.interpolation_method); 
        W2 = warp_inverse (small_img2, Dx, Dy, PARA.interpolation_method); 
        [Dx, Dy] = HS_Estimation(W1,W2,lambda,PARA.ite,Dx,Dy,PARA.boundaryCondition);

        if (isMedianFilter == true)
            Dx = medfilt2(Dx,sizeOfMF,'symmetric'); 
            Dy = medfilt2(Dy,sizeOfMF,'symmetric');
        end
        

    end

end


