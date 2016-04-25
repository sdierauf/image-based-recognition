% Stefan Dierauf
% 25/4/2016
warning('off','all');
% Exercise 1: The Pegasos Algorithm - training an SVM with SGD
% Your first task is to use the function vl hog in the software package vl 
% feat to extract the HOG descriptor of each image patch in the training set.
% The function vl hog takes as input two variables one is the image 
% (where it is assumed the intensity values of the image are stored as single?s) 
% and the other is a whole number defining the size of each cell. 
% For this assignment set cellSize = 4. 
% To convert the image im to type single you can use the command
%      im = im2single(im)
% You should create a matrix Xtrain of size d×n where each column of Xtrain 
% is the HOG descriptor of a training image and it is assumed we have n 
% training images.
% Training of an SVM is usually more stable if the values in each dimension 
% of the feature vector have the same scale and are centred. Therefore you 
% should normalize Xtrain so that each row has mean 0 and standard deviation 1. 
% Keep a record of the means and standard deviations that you compute because 
% these will be needed at test time.

cellSize = 4;
training_data = load('pedestrian_training.mat');
training_images = training_data.ims;
training_labels = training_data.y; 
Xtrain = zeros(1395, length(training_images));
Xtrain_mean = zeros(1, length(training_images));
Xtrain_stdDev = zeros(1, length(training_images));

for i = 1:size(training_images, 2)
    img = training_images{1, i};
    img_single = im2single(img);
    res = vl_hog(img_single, cellSize);
    res_vector = res(:)';
    Xtrain(:, i) = zscore(res_vector);
    Xtrain_mean(:, i) = mean(res_vector);
    Xtrain_stdDev(:, i) = std(res_vector);
end

% Now you have training data D stored in Xtrain. Next you will implement the 
% algorithm called the The Pegasos Algorithm, which is an implementation of 
% the SGD algorithm to minimizing equation (1). The steps of the Pegasos 
% Algorithm are as follows:


% ? Input: D = {(x1,y1),...,(xn,yn)}, ?, T
% ? Initialize: Setw=0andb=0


% ? Choose it ? {1, . . . , n} uniformly at random.
% ? Set ?t = 1 .
%  ?t
% ? Ifyit(wtTxit +bt)<1then
% else
% wt+1 = (1??t ?)wt +?t yit xit bt+1 = bt + ?t yit
% wt+1 = (1 ? ?t ?)wt bt+1 = bt
% ? (Optional: Normalize the parameters that is  1 
% a=min 1, wt+1 = a wt+1
% bt+1 = a bt+1
% ?wt+1 ?
% ?
% ?
% (2)
% (3) (4)
%   )
% ? Output:
% wT +1 , bT +1

[w, b] = TrainSVM(Xtrain, training_labels, 0.0001, 9800);

yy = w' * Xtrain + b;
ys = sign(yy);
wrong = sum(ys' ~= training_labels)
(9800 - wrong)/9800

