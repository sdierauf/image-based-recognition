% Stefan Dierauf
% 25/4/2016
% Exercise 2: accuracy 0.8918

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

[w, b] = TrainSVM(Xtrain, training_labels, 0.0001, 9800);

yy = w' * Xtrain + b;
ys = sign(yy);
wrong = sum(ys' ~= training_labels)
training_size = size(Xtrain, 2);
(training_size - wrong)/training_size

test_data = load('pedestrian_test.mat');
test_images = test_data.ims;
test_labels = test_data.y;
Xtest = zeros(1395, length(test_images));


for i = 1:size(training_images, 2)
    img = test_images{1, i};
    img_single = im2single(img);
    res = vl_hog(img_single, cellSize);
    res_vector = res(:)';
    Xtest(:, i) = res_vector;
end

training_mean = sum(Xtrain_mean) / training_size;
training_stdDev = sum(Xtrain_stdDev) / training_size;

% zscore-ing with training mean and stdDev
Xtest = (Xtest - training_mean) / training_stdDev;

yy = w' * Xtest + b;
ys = sign(yy);
test_size = size(Xtest, 2);
wrong = sum(ys' ~= test_labels)
(test_size - wrong)/test_size
