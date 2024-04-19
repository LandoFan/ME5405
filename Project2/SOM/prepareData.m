function [trainData, trainLabels, valData, valLabels] = prepareData(baseFolder, subFolders, imageSize)

    % Initialize the data set
    allData = [];
    allLabels = [];

    % Read pictures
    for i = 1:length(subFolders)
        folder = fullfile(baseFolder, subFolders{i});
        files = dir(fullfile(folder, '*.png'));
        num_files = length(files);
        % Traverse pictures in a folder
        for j = 1:num_files
            img = imread(fullfile(folder, files(j).name));
            % RGB to GRAY
            if size(img, 3) == 3
                img = rgb2gray(img);
            end
            % Resize image
            img = imresize(img, imageSize);
            % Save Data and Labels
            img_Vector = img(:)';
            img_Vector = double(img_Vector)/255;
            allData = [allData; img_Vector];
            allLabels = [allLabels;i];
        end
    end

    % Randomly shuffle data and labels
    randIndices = randperm(size(allData, 1));
    allData = allData(randIndices, :);
    allLabels = allLabels(randIndices, :);
    
    % Split training data and validation data
    numTrain = floor(0.75 * size(allData, 1));
    trainData = allData(1:numTrain, :);
    trainLabels = allLabels(1:numTrain, :);
    valData = allData(numTrain+1:end, :);
    valLabels = allLabels(numTrain+1:end, :);

end