% this script trains and tests a KNN algorithm on images of letters

% define the feature space. This can be one of the following
% 'fourier' - fourier transform
% 'hog' - histogram oriented gradients
% 'wavelet' - wavelet transform
featureSelect = 'hog';
imageSize = [32, 32]; % Define the desired size of all images
K = 1; % K-value for KNN algorithm - this will be overridden by the optimal K-value if calcAccuracy is run

letters = ['D','E','H','L','O','R','W']; % the letters in the dataset

% run the desired sections of code (1-run, 0-don't run)
reloadImgs = 1; % reload image data and features for the KNN algorithm
calcAccuracy = 1; % compute the accuracy of the KNN algorithm at different k-values
testKNN = 1; % test the KNN algorithm on segmented data from previous tasks

% reload image data and features for the KNN algorithm
if reloadImgs
   
    % Define folders and parameters
    baseFolder = 'p_dataset_26';
    subFolders = {'SampleD', 'SampleE', 'SampleH', 'SampleL', 'SampleO', 'SampleR', 'SampleW'}; 
    
    % Prepare KNN data
    [trainFeatures, trainData, trainLabels, valFeatures, valData, valLabels] = prepareData(baseFolder, subFolders, imageSize, featureSelect);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute the accuracy of the KNN algorithm at different k-values
if calcAccuracy

    %K_vals = 1:10:101;
    K_vals = 1:2:11;

    % initialize arrays/variables
    accuracy = zeros(1,max(K_vals));
    accuracy_letter = zeros(length(accuracy),max(valLabels),3);
    
    for K = K_vals

        % initialize arrays/variables
        nearest_neighbours = zeros(1,K);
        val_rows = length(valLabels);
        prediction = zeros(1,val_rows);
        correct = 0;
        
        % classify all validation data
        for i = 1:length(valLabels)
            % make a prediction using KNN
            prediction(i) = classifyKNN(K,valFeatures(i,:),trainFeatures,trainLabels);
            
            % record data for confusion table
            known_labels(K,i) = letters(valLabels(i));
            predicted_labels(K,i) = letters(prediction(i));

            % determine if prediction is correct and update accuracy
            % accordingly
            if prediction(i) == valLabels(i)
                correct = correct + 1;
                accuracy_letter(K,valLabels(i),1) = accuracy_letter(K,valLabels(i),1) + 1;
            end
            accuracy_letter(K,valLabels(i),2) = accuracy_letter(K,valLabels(i),2) + 1;
            accuracy(i,K) = (correct * 100)/i;
            disp(K);
            disp(i);
            disp(accuracy(i,K));
        end
    end
    % plot accuracy by k-value
    figure;
    scatter(K_vals,accuracy(end,K_vals));
    ylabel('Overall Percentage Accuracy');
    xlabel('K');
    % compute accuracy by letter
    accuracy_letter(:,:,3) = (accuracy_letter(:,:,1)./accuracy_letter(:,:,2)) * 100;

    % find the optimal K based on accuracy
    [~,K] = find(accuracy == max(accuracy(end,:)),1);

    % plot the confusion matrix for the best K-value
    figure;
    cm = confusionchart(known_labels(K,:)',predicted_labels(K,:)')
    cm.RowSummary = 'row-normalized';
    cm.ColumnSummary = 'column-normalized';

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% test the KNN algorithm on segmented data from previous tasks
if testKNN
    
    % Define folders and parameters
    folder = 'HELLO WORLD'; 
    testData = [];
    testLabels = [];
    
    % Traverse thorugh segmented test data
    files = dir(fullfile(folder, '*.jpg'));
    num_files = length(files);
    for j = 1:num_files

        % compute features of the image ot be classified
        [testImg, testFeatures] = prepareImg(fullfile(folder, files(j).name),imageSize,featureSelect);
        testLabels = [testLabels,files(j).name(1)];
        
        % predict class of the image
        testPrediction(j) = classifyKNN(K,testFeatures,trainFeatures,trainLabels);

        % map the prediction to the letter
        testPredictionLetter(j) = letters(testPrediction(j));
    end
end
