clear;
clc;

%% Read the new image
newImagePath = 'E.png'; 
newImage = imread(newImagePath);

%% preprocess image
imageSize = [64,64];
processedNewImage = preprocessImage(newImage, imageSize);

%% Classify images using SOM
load('trainedSOM.mat', 'net', 'neuronLabels');

% Make sure input data sizes do match net.inputs{1}.size
if length(processedNewImage) ~= net.inputs{1}.size
    disp(length(processedNewImage));
    disp(net.inputs{1}.size);
    error('The size of the input image vector does not match the network input size.');
end

outputs = net(processedNewImage);

% Find the most activated neuron
[~, winningNeuron] = max(outputs);
predictedLabel = neuronLabels(winningNeuron);

%Create an array mapping numbers to letters
labelMapping = ['D', 'E', 'H', 'L', 'O', 'R', 'W'];
predictedLetter = labelMapping(predictedLabel);

%% Output prediction results
fprintf('The predicted label for the new image is: %s\n', predictedLetter);
