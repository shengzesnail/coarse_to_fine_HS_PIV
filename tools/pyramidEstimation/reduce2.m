%% The Reduce Function for pyramid   
% down-sampling
function result = reduce2 (ori, interpolation_method)
if nargin < 2
    interpolation_method = 'linear';
end;

% Step 1: low-pass filtering
w = [1/16,1/8,1/16;1/8,1/4,1/8;1/16,1/8,1/16];
mid = conv2(ori, w, 'same');
% mid = smoothImg(ori,0.6,5);
% Step 2: interpretation
[m,n] = size (ori);
[x,y] = meshgrid (1:n, 1:m);
x = x + 1/2; y = y + 1/2;
for i=1:m,
    for j=1:n,
        if x(i,j)>n
            x(i,j) = n;
        end
        if x(i,j)<1
            x(i,j) = 1;
        end
        if y(i,j)>m
            y(i,j) = m;
        end
        if y(i,j)<1
            y(i,j) = 1;
        end
    end
end

if strcmp(interpolation_method, 'bi-cubic')
    h = [1 -8 0 8 -1]/12;           % used in Wedel etal "improved TV L1"
    temp = interp2_bicubic(mid,x,y, h);
else
    temp = interp2 (mid, x, y, interpolation_method);
end

result = temp(1:2:m,1:2:n);
