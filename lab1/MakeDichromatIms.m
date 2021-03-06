% Stefan Dierauf
% 24/4/2016

function [ pim, dim ] = MakeDichromatIms( im )
%MAKEDICHROMATIMS Summary of this function goes here
%   Detailed explanation goes here
% im = image 
% pim = protan transformed image
% dim = deutan transformed image

raw = double(im);
R = raw(:, :, 1);
G = raw(:, :, 2);
B = raw(:, :, 3);

r = (R ./ 255).^2.2;
g = (G ./ 255).^2.2;
b = (B ./ 255).^2.2;

rp = times(0.992052, r) + 0.003974;
gp = times(0.992052, g) + 0.003974;
bp = times(0.992052, b) + 0.003974;

rd = times(0.957237, r) + 0.0213814;
gd = times(0.957237, g) + 0.0213814;
bd = times(0.957237, b) + 0.0213814;

lms_matrix = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709];
rgbp = [rp(:)'; gp(:)'; bp(:)'];
rgbd = [rd(:)'; gd(:)'; bd(:)'];
P = inv(lms_matrix) * [0 2.02344 -2.52581; 0 1 0; 0 0 1] * lms_matrix * rgbp;
D = inv(lms_matrix) * [1 0 0; 0.49207 0 1.24827; 0 0 1] * lms_matrix * rgbd;

Pundo = 255 * (P .^(1/2.2));
Dundo = 255 * (D .^(1/2.2));

pim = zeros(size(im, 1), size(im,2), size(im, 3));
pim(:, :, 1) = reshape(Pundo(1, :), size(im, 1), size(im, 2));
pim(:, :, 2) = reshape(Pundo(2, :), size(im, 1), size(im, 2));
pim(:, :, 3) = reshape(Pundo(3, :), size(im, 1), size(im, 2));
pim = uint8(pim);
dim = zeros(size(im, 1), size(im,2), size(im, 3));
dim(:, :, 1) = reshape(Dundo(1, :), size(im, 1), size(im, 2));
dim(:, :, 2) = reshape(Dundo(2, :), size(im, 1), size(im, 2));
dim(:, :, 3) = reshape(Dundo(3, :), size(im, 1), size(im, 2));
dim = uint8(dim);

end

