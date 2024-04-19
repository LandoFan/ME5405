function [prediction] = classifyKNN(K,sampleFeatures,trainFeatures,trainLabels)
% this function attempts to classify an image of a letter using a KNN
% algorithm and set of training data
% input:    K - k-value used for KNN algorithm
%           sampleFeatures - the features associated with the image to be classified
%           trainFeatures - the features of all training data
%           trainLabels - the labels of all training data
% output:   prediction - the predicted classification of the input image

    % initialize variables
    [numData,~] = size(trainFeatures);

    % measure distance betwen test sample and all data in the training
    % set
    for j = 1:numData
        dist(j) = sqrt(sum((sampleFeatures - trainFeatures(j,:)).^2));
    end

    % obtain the indices of the neighbours with the smallest distance
    [test, index_sorted_dist] = sort(dist,'ascend');
    nearest_neighbours(1:K) = trainLabels(index_sorted_dist(1:K));

    % the most common value within the neighbourhood is the prediction
    prediction = mode(nearest_neighbours);