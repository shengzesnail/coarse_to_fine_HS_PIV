%% The Expansion Function for pyramid 
% Project the velocity field to next pyramid level
function result = expand2 (ori,interpolation_method)   
if nargin < 2
    interpolation_method = 'linear';
end;

[m,n] = size (ori);
m1 = m * 2; n1 = n * 2;
result1 = zeros (m1, n1);
w = [0.5,1,0.5];
for j=1:m
   t = zeros (1, n1);
   t(1:2:n1) = ori (j,1:n);
   tmp = conv ([0 t ori(j,1)], w, 'same');
   mid(j,1:n1) = tmp(2:end-1);
end
for i=1:n1
   t = zeros (1, m1);
   t(1:2:m1) = mid (1:m,i)'; 
   tmp = conv ([0 t mid(1,i)], w, 'same');
   result1(1:m1,i) = tmp(2:end-1)';
end
[m, n] = size (result1);
[x,y] = meshgrid (1:n, 1:m);
x = x - 1/2; y = y - 1/2;
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
    result = interp2_bicubic(result1,x,y, h);
else
    result = interp2 (result1, x, y, interpolation_method);
end

