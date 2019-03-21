function varargout = computeDerivatives_f(im1, im2, boundaryCondition)
% compute Ix,Iy,It

if size(im2,1)==0
    im2=zeros(size(im1));
end

%% compute the local average
kernel=1/16 .*[1 1 1;1 8 1;1 1 1];
% kernel=1/4 .*[0 1 0;1 0 1;0 1 0];
im1 = imfilter(im1, kernel,  'corr', 'replicate', 'same');
im2 = imfilter(im2, kernel,  'corr', 'replicate', 'same');

%% Horn-Schunck original method
% fx = conv2(im1,0.25* [-1 1; -1 1],'same') + conv2(im2, 0.25*[-1 1; -1 1],'same');
% fy = conv2(im1, 0.25*[-1 -1; 1 1], 'same') + conv2(im2, 0.25*[-1 -1; 1 1], 'same');
% ft = conv2(im1, 0.25*ones(2),'same') + conv2(im2, -0.25*ones(2),'same');

%% derivatives as in Barron 2005
% fx= conv2(im1,(1/12)*[-1 8 0 -8 1],'same');
% fy= conv2(im1,(1/12)*[-1 8 0 -8 1]','same');
% ft = conv2(im1, 0.25*ones(2),'same') + conv2(im2, -0.25*ones(2),'same');
% fx=-fx;fy=-fy;

%% An alternative way to compute the spatiotemporal derivatives is to use simple finite difference masks.
% easiest way for derivatives computing
% fx = conv2(im1,[1 -1]);
% fy = conv2(im1,[1; -1]);
% ft= im2-im1;


%% 
h = [-1 9 -45 0 45 -9 1]/60;        % derivative used by Bruhn et al "combing "IJCV05' page218
% h = [1 -8 0 8 -1]/12;               % used in Wedel etal "improved TV L1"
ft        = im2 - im1;    
if strcmp(boundaryCondition,'periodical')
    bounMargin = 3;
    im1_temp = [im1(end-bounMargin+1:end,:);im1;im1(1:bounMargin,:)];
    im1_period = [im1_temp(:,end-bounMargin+1:end),im1_temp,im1_temp(:,1:bounMargin)];
    im2_temp = [im2(end-bounMargin+1:end,:);im2;im2(1:bounMargin,:)];
    im2_period = [im2_temp(:,end-bounMargin+1:end),im2_temp,im2_temp(:,1:bounMargin)];
    fx        = 0.5*(imfilter(im1_period, h,  'corr', 'symmetric', 'same')+...
        imfilter(im2_period, h,  'corr', 'symmetric', 'same') );  %
    fy        = 0.5*(imfilter(im1_period, h', 'corr', 'symmetric', 'same')+...
        imfilter(im2_period, h', 'corr', 'symmetric', 'same') );
    fx = fx(bounMargin+1:end-bounMargin, bounMargin+1:end-bounMargin);
    fy = fy(bounMargin+1:end-bounMargin, bounMargin+1:end-bounMargin);
else
    fx        = 0.5*(imfilter(im1, h,  'corr', 'symmetric', 'same')+...
        imfilter(im2, h,  'corr', 'symmetric', 'same') );  %
    fy        = 0.5*(imfilter(im1, h', 'corr', 'symmetric', 'same')+...
        imfilter(im2, h', 'corr', 'symmetric', 'same') );
end
varargout = [{fx}, {fy}, {ft}];


%% laplace operator
if nargout >= 4
    w = [0 1 0;1 -4 1;0 1 0];
	fxy = 0.5*(imfilter(im1, w,  'corr', 'symmetric', 'same')+...
        imfilter(im2, w,  'corr', 'symmetric', 'same') ); 
    varargout(4) = {fxy};
end

if nargout >= 5
    f_avg = smoothImg(im2,1);
    f_avg_avg = smoothImg(f_avg,1);
    varargout(5) = {f_avg};
    varargout(6) = {f_avg_avg};
end

