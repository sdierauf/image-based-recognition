function [w, b] = TrainSVM(Xtrain, ys, lambda, T)
%TRAINSVM Summary of this function goes here
%   Detailed explanation goes here
w = 0;
b = 0;

% ? for t = 1,2,...,T
XtrainT = transpose(Xtrain);
[N,d]=size(XtrainT);
% lambda = 1; % who knows how big this is
k = ceil(0.1*N);
w=rand(1,size(XtrainT, 2));
w=w/(sqrt(lambda)*norm(w));
w
maxIter = T;
Y = ys;

for t=1:maxIter
    inds = randperm(XtrainT);
    b = mean(Y-XtrainT*w(t,:)');
    for idx = 1:inds
        At = XtrainT(idx,:);
        yt = Y(idx, :);
        etat = 1/(lambda*t);
        if (yt < 1)
            idx1 = (At*w(t,:)'+b);
            w1 = (1-etat*lambda)*w(t,:) + (etat*yt) % +(etat/k)*sum(At(idx1,:).*repmat(yt(idx1,:),1,size(At,2)),1);
        else
            w1 = (1-etat*lambda)*w(t, :);
            b = 
        end
    end
    w(t+1,:) = min(1,1/(sqrt(lambda)*norm(w1)))*w1;
end

wT=mean(w,1);
w = wT;
b=mean(Y-XtrainT*wT');
% Tr=sum(sign(XtrainT*wT'+b)==Y);
% F=size(XtrainT,1)-Tr;

end

