function [w, b] = TrainSVM(Xtrain, ys, lambda, T)
%TRAINSVM Summary of this function goes here
%   Detailed explanation goes here
w = 0;
b = 0;

% ? for t = 1,2,...,T

[d, n]=size(Xtrain);
w = zeros(d, 1);
epochs = 20;

for i = 1:epochs
    inds = randperm(n);
    for t = 1: T
        nt = 1/(lambda*t);
        yt = ys(inds(t));
        xt = Xtrain(:, inds(t));
        if (yt * (w' * xt + b) < 1)
            w = (1 - nt*lambda) * w + nt * yt * xt;
            b = b + nt * yt;
        else
            w = (1 - nt*lambda) * w;
        end
    end
    a= min(1, 1/(norm(w) * sqrt(lambda)));
    w = a* w;
    b = a * b;
end




% Tr=sum(sign(XtrainT*wT'+b)==Y);
% F=size(XtrainT,1)-Tr;

end

