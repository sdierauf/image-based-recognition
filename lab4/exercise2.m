% Stefan Dierauf
% 26/4/2016
% Exercise 2
% Learn linear separating hyperplane for a ConvNet representation


net = load('imagenet-vgg-f.mat');
inria_train = load('inria_train.mat');
 inria_test = load('inria_test.mat');
train_images = inria_train.ims;
train_labels = inria_train.labels;
layers = 18;
best_layer = 1;
num_wrong = 588;
for layer = 15:layers
    img = train_images{1, 1};
    im_ = single(img);
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
    im_ = im_ - net.meta.normalization.averageImage;
    res = vl_simplenn(net, im_);
    rep = squeeze(gather(res(layer+1).x));

    trainX = zeros(size(rep, 1), size(train_images, 2));

    for i = 1:size(train_images, 2)
        img = train_images{1, i};
        im_ = single(img);
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
        im_ = im_ - net.meta.normalization.averageImage;
        res = vl_simplenn(net, im_);
        rep = squeeze(gather(res(layer+1).x));
        trainX(: , i) = rep;
    end

    [w, b] = TrainSVM(trainX, train_labels, 0.0001, size(train_images, 2));

    yy = w' * trainX + b;
    ys = sign(yy);
    wrong = sum(ys' ~= train_labels)
    training_size = size(trainX, 2);
    (training_size - wrong)/training_size

    test_images = inria_test.ims;
    test_labels = inria_test.labels;
    testX = zeros(4096, size(test_images, 2));

    for i = 1:size(test_images, 2)
        img = test_images{1, i};
        im_ = single(img);
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
        im_ = im_ - net.meta.normalization.averageImage;
        res = vl_simplenn(net, im_);
        rep = squeeze(gather(res(layer+1).x));
        testX(: , i) = rep;
    end

    yy = w' * testX + b;
    ys = sign(yy);
    wrong = sum(ys' ~= test_labels)
    test_size = size(testX, 2);
    (test_size - wrong)/test_size
    if (wrong < num_wrong)
        best_layer = layer;
    end
end

best_layer



