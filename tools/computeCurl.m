function [vort] = computeCurl(uv)

u = uv(:,:,1);
v = uv(:,:,2);

%% simple kernel
u1 = [u(1,:);u;u(end,:)];       % add boundary 
u = [u1(:,1),u1,u1(:,end)];
v1 = [v(1,:);v;v(end,:)];       % add boundary 
v = [v1(:,1),v1,v1(:,end)];
kernel = [-1 0 1;
        -2 0 2;
        -1 0 1]./8;
% kernel = [-0 0 0;
%         -1 0 1;
%         -0 0 0]./2;
uy = conv2(u,kernel','same');
vx = conv2(v,kernel,'same');
uy = uy(2:end-1,2:end-1);
vx = vx(2:end-1,2:end-1);
vort = vx-uy;

%% complex kernel 
h = [-1 9 -45 0 45 -9 1]/60;        % derivative used by Bruhn et al "combing "IJCV05' page218
vx        = imfilter(v, h,  'corr', 'symmetric', 'same');  %
uy        = imfilter(u, h', 'corr', 'symmetric', 'same');
vort = vx-uy;
