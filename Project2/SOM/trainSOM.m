function net = trainSOM(trainData, gridDimensions)
    % SOM network settings
    dimensions = [gridDimensions,gridDimensions];
    net = selforgmap(dimensions); % Dimensions
    net = configure(net, trainData'); % trainData
    net.trainParam.epochs = 400; % Max epochs
    net = train(net, trainData');
    save('trainedSOM.mat', 'net');
end