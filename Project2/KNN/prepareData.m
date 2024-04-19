function [trainFeatures, trainData, trainLabels, valFeatures, valData, valLabels] = prepareData(baseFolder, subFolders, imageSize, featureSelect)
% this function reads a set of images, and outputs the data required to
% train and test a KNN algorithm. 3/4 of the images are used for training,
% and the remaining 1/4 is used for validation.
% Inputs:   baseFolder - the name of the folder containing the sample data
%           subFolders - the names of all subfolders within basefolder. Each subfolder contains sample images for one letter.
%           imageSize - the number of rows and columns of all images after processing.
%           featureSelect - the feature to be extracted (fourier transform, gradient, wavelet, or HOG)
% Outputs:  trainFeatures - the feature information for all training images. 
%           trainData - all training images
%           trainLabels - all training labels
%           valFeatures - the feature information for all validation images. 
%           valData - all validation images
%           valLabels - all validation labels


    % Initialize the data set
    allData = [];
    allLabels = [];
    allFeatures = [];
    
    % Read pictures
    for i = 1:length(subFolders)

        folder = fullfile(baseFolder, subFolders{i});
        files = dir(fullfile(folder, '*.png'));
        num_files = length(files);

        % Traverse pictures in a folder
        for j = 1:num_files
            % process image and compute chosen feature
            [img, features] = prepareImg(fullfile(folder, files(j).name),imageSize,featureSelect);
            allFeatures = [allFeatures; features];
            allData = cat(3,allData,img);
            allLabels = [allLabels;i];
            disp(num2str(i) + " " + num2str(j));

        end
    end

    % Randomly shuffle data and labels
    randIndices = randperm(size(allLabels, 1));
    allFeatures = allFeatures(randIndices, :);
    allData = allData(:, :, randIndices);
    allLabels = allLabels(randIndices, :);

    % Split training data and validation data
    numTrain = floor(0.75 * size(allLabels, 1));
    trainData = allData(:, :, 1:numTrain);
    trainFeatures = allFeatures(1:numTrain,:);
    trainLabels = allLabels(1:numTrain, :);
    valData = allData(:, :, numTrain+1:end);
    valFeatures = allFeatures(numTrain+1:end, :);
    valLabels = allLabels(numTrain+1:end, :);

end

