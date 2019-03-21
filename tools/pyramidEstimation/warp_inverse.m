%% Symmetric Warping and Interpolation %%
% warp_inverse() 
function result = warp_inverse (img, Dx, Dy, interpolation_method)
if nargin < 4
    interpolation_method = 'spline';
end;

[m, n] = size (img);
[x,y] = meshgrid (1:n, 1:m);
x = x + 1/2*Dx (1:m, 1:n); y = y + 1/2*Dy (1:m,1:n);
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
    result = interp2_bicubic(img, x, y, h);
else
    result = interp2 (img, x, y, interpolation_method);
end
