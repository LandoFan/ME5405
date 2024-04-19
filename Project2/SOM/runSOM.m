clear;
clc;

% Define folders and parameters
baseFolder = 'p_dataset_26';
subFolders = {'SampleD', 'SampleE', 'SampleH', 'SampleL', 'SampleO', 'SampleR', 'SampleW'}; 
imageSize = [32, 32]; % Define the desired size of all images

% Prepare data
[trainData, trainLabels,valData,valLabels] = prepareData(baseFolder, subFolders, imageSize);
% 保存四个变量到一个.mat文件中
save('data_variables.mat', 'trainData', 'trainLabels', 'valData', 'valLabels');
% Train SOM network
% gridDimensions = [sqrt(size(trainData, 1)), sqrt(size(trainData, 1))];
% gridDimensions = round(gridDimensions);
gridDimensions = 15; % Define the SOM grid
net = trainSOM(trainData, gridDimensions);

% Evaluate network performance
[neuronLabels, hitsMatrix] = evaluateSOM(net, valData, valLabels, subFolders);
% Save neuron data labels
save('trainedSOM.mat', 'net', 'neuronLabels', '-append');