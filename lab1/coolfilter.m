function [ a ] = coolfilter( im )
%FILTER Summary of this function goes here
%   Detailed explanation goes here
raw = double(im);
R = raw(:, :, 1);
G = raw(:, :, 2);
B = raw(:, :, 3);

R = reshape(R, size(im, 1), size(im, 2));
G = reshape(G, size(im, 1), size(im, 2));
B = reshape(B, size(im, 1), size(im, 2));

% R = R .* 2;

a = reshape([R, G, B], size(im, 1), size(im, 2), []);

end

