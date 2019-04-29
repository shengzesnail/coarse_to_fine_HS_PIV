function [RMSE]=flowAngErr(tu, tv, u, v, bord, varargin)
% return the Barron et al angular error.  bord is the pixel width of the
% border to be ingnored.
if nargin<5
    bord = 0;
end
% if length(varargin) == 1
%     % mask
%     tu(~varargin{1}) = 0;
%     tv(~varargin{1}) = 0;
% end;

%%
smallflow=0.0;
   
%% ignore the border of image if necessary
stu=tu(bord+1:end-bord,bord+1:end-bord);
stv=tv(bord+1:end-bord,bord+1:end-bord);
su=u(bord+1:end-bord,bord+1:end-bord);
sv=v(bord+1:end-bord,bord+1:end-bord);

%% ignore the points whose velocities are zero
% ignore a pixel if both u and v are zero 
% ind2=find((stu(:).*stv(:)|sv(:).*su(:))~=0);
ind2=find(abs(stu(:))>smallflow | abs(stv(:)>smallflow));
%length(ind2)


%% compute RMSE
    DIS = (stu-su).^2 + (stv-sv).^2;
    DIS = DIS(ind2);
    DIS_sum = mean(mean(DIS));
    RMSE = ( sqrt(DIS_sum) ) ;

% show which pixels were ignored
% tmp=zeros(size(su));
% tmp(ind2)=1;
% imagesc(tmp)