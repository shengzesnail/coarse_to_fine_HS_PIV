% function main
%% Variational Optical Flow Method for Fluid Flows
% using the multi-resolution (coarse-to-fine) implementation of 
%   Horn & Schunck (HS) optical flow method
% *************************************
% Shengze Cai 2016/03
% *************************************
% Modified by Shengze Cai 2016/12
% **************************************

clear all;
close all;
clc
addpath(genpath('tools'));
addpath(genpath('data'));

%% Parameters settings
PARA.pyramid_level = 3;     % number of pyramidal levels
PARA.warp_iter = 2;         % number of warping steps
PARA.ite = 400;
% boundary condition 
PARA.boundaryCondition = 'periodical';  % replicated  periodical  slip
PARA.interpolation_method = 'spline';

% divergence-free decomposition and the settings
PARA.isMedianFilter = true;     % if median filtering 
PARA.sizeOfMF = [5,5];          % window size of median filter

% initialize the velocity field
uInitial=zeros(256,256);    % 
vInitial=zeros(256,256);
uvInitial = cat(3,uInitial,vInitial);


%% load images
imFileDir   = ['data' filesep];
flowName = 'DNS_turbulence_00001';     
im1         = imread([imFileDir flowName '_img1.tif']);
im2         = imread([imFileDir flowName '_img2.tif']);
% display
figure('color',[1,1,1]); imshow(im1,[]);    title('First frame');
figure('color',[1,1,1]); imshow(im2,[]);    title('Second frame');


%% compute the variational optical flow
lambda = 10;        % smoothing parameter
tic
[u, v] = HS_Pyramids(im1,im2,lambda,PARA);
toc
uv = cat(3,u,v);


%% Display estimated flow fields
% figure; 
vort = computeCurl(uv);  % compute the vorticity of the fields
plotFlow_Cai(u, v, []);    % Plot estimated flow field (vector)
% plotFlow_Cai(u, v, vort);    % Plot estimated flow field with vorticity
title('Estimated Flow Field')



%% if GT flow is available
isGT = true;
if isGT == true
    % load the ground-truth
    gt_filename = [imFileDir flowName '_flow.flo'];
    uv_gt = readFlowFile(gt_filename);
    
    % display the ground-truth
    vort_gt = computeCurl(uv_gt);
    plotFlow_Cai(uv_gt(:,:,1), uv_gt(:,:,2), []);   
    title('Ground-truth Flow Field');

	%% Compute AAE, EPE, RMSE
    margin = 0;      % eliminate the border
    [aae, stdae, aepe, rmse] = ...
        flowAngErr(uv_gt(:,:,1), uv_gt(:,:,2), uv(:,:,1), uv(:,:,2),margin);
    fprintf('All pixels considered AAE %3.3f STD %3.3f \n', aae, stdae);
    fprintf('All pixels considered EPE %3.3f RMSE %3.3f \n', aepe, rmse);
end



