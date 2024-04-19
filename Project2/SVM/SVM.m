% reference: https://blog.csdn.net/qq_32892383/article/details/79779513
clear;
clc;
data = imageDatastore(fullfile('p_dataset_26'),'IncludeSubfolders',true,'LabelSource','foldernames');
% 75% training, 25% testing
[train_set, test_set] = splitEachLabel(data,0.75);
%% get HOG features
padding_size = 128;
padding_size = [padding_size padding_size];
img = readimage(data,1);
img = imresize(img,padding_size);
[hog, fig] = extractHOGFeatures(img,'CellSize',[8 8]);

figure(20);

subplot(2,1,1); 
imshow(img);
subplot(2,1,2);
plot(fig);

title({'CellSize = [8 8]'; ['Length = ' num2str(length(hog))]});
% saveas(gcf,'HOG_cell16.png')
cell_size = [8 8];
feature_size = length(hog);

%% feature extraction 
% extract features in the training dataset
num = numel(train_set.Files);


for i = 1:num
    img = readimage(train_set,i);
    img = imresize(img,padding_size);
    training_features(i,:) = extractHOGFeatures(img,'CellSize',cell_size);
end

training_labels = train_set.Labels;

% extract features in the test dataset
num = numel(test_set.Files);

for i = 1:num
    img = readimage(test_set,i);
    img = imresize(img,padding_size);
    test_features(i,:) = extractHOGFeatures(img,'CellSize',cell_size);
end

test_labels = test_set.Labels;

%% train SVM classifier
tic
svm_classifier = fitcecoc(training_features,training_labels); 
toc
% save('svm_classifier.mat',"svm_classifier")
%% result of SVM
predict_labels = predict(svm_classifier, test_features);

% confusion matrix
figure(30);

plotconfusion(test_labels, predict_labels);
xlabel("Target Character")
ylabel("Output Character")
title("The accuracy of the SVM classifier")
% saveas(gcf,'confusionmatrix_cell16.png')
%% test using hello world if you want to test, you can just run this part by uncommenting
% clear all
% clc
% load("svm_classifier.mat")
dic = ["H","E","L","O","W","R","D"];
figure(31)

for i = 1 : length(dic)
    subplot(2,4,i)
    img_path = sprintf('HELLO WORLD\\%s.jpg', dic(i));
    img2 = imread(img_path);
    imshow(img2)
    img2 = imresize(img2,padding_size);
    img2 = imbinarize(img2,0.5);
    [hog, fig] = extractHOGFeatures(img2,'CellSize',[8 8]);
    % feature_size = length(hog);
    predict_labels = predict(svm_classifier, hog);
    str = ['Result：' predict_labels];
    title(sprintf('%s', str));
end

% saveas(gcf,'Test_cell32_16.png')
