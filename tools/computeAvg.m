function [xAvg] = computeAvg(x,kernel,boundaryCondition)
% return the local average matrix
if nargin < 3
	boundaryCondition = 'periodical';
end
if strcmp(boundaryCondition,'periodical')
  	x1 = [x(end,:);x;x(1,:)];
    x = [x1(:,end),x1,x1(:,1)];
else
    x1 = [x(1,:);x;x(end,:)];
    x = [x1(:,1),x1,x1(:,end)];
end

xAvg = conv2(x,kernel,'same');
xAvg = xAvg(2:end-1,2:end-1);
% the following function provides the same result as above
% but it is time-consuming
% xAvg = imfilter(x, kernel,  'corr', 'replicate', 'same');
