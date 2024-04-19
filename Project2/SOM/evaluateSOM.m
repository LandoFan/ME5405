function [neuronLabels, hitsMatrix] = evaluateSOM(net, valData, valLabels, subFolders)

    % Test the SOM network using validation set data
    valHits = net(valData');

    % Display the trained feature map to understand how different neurons respond to the data
    figure;
    plotsom(net.IW{1,1}, net.layers{1}.distances);
    title('Feature Map after Training');

    % Plot neuron hits for validation data
    % The number of responses of each neuron to the verification data
    figure;
    plotsomhits(net, valData');
    title('Verify the Number of Hits for Each Neuron on the Data');

    % If the SOM toolbox is installed, you can also visualize the U matrix
    try
        figure;
        plotsomumatrix(net);
        title('U Matrix');
    catch
        disp('SOM toolbox not found or other error when drawing U matrix.');
    end

    % Calculate the number of label hits corresponding to each neuron
    % Analyze by counting which neurons respond most frequently to a given label
    [neuronIndices, distances] = vec2ind(valHits);
    neuronLabels = vec2ind(net(valData'));

    % Initialize the hit matrix, used to record the number of responses of each neuron to each label
    hitsMatrix = zeros(size(net.IW{1,1},1), length(subFolders));
    for i = 1:length(neuronIndices)
        actualLabel = valLabels(i); 
        neuronIdx = neuronIndices(i); 
        hitsMatrix(neuronIdx, actualLabel) = hitsMatrix(neuronIdx, actualLabel) + 1; 
    end
    
    % Show hit matrix
    figure;
    imagesc(hitsMatrix);
    colormap(jet); 
    colorbar; 
    xlabel('Actual Label');
    ylabel('Neurons');
    title('Hit Matrix');

    % Initialize the neuron label mapping array
    neuronLabels = zeros(size(net.IW{1,1},1), 1);

    % For each neuron, find the label with the most responses
    for neuronIdx = 1:size(net.IW{1,1},1)
        [~, labelIdx] = max(hitsMatrix(neuronIdx, :));
        neuronLabels(neuronIdx) = labelIdx;
    end

    % Calculate accuracy
    correct = 0;
    for i = 1:length(neuronIndices)
        [~, predicted] = max(hitsMatrix(neuronIndices(i), :)); 
        if predicted == valLabels(i) 
            correct = correct + 1;
        end
    end
    accuracy = correct / length(valLabels); 
    fprintf('Validation Set Accuracy: %.2f%%\n', accuracy * 100);
end