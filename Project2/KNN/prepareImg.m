function [img, features] = prepareImg(path,imageSize,featureSelect)
% this function performs processing on an image and computes the desired
% features
% inputs:   path - the file path to the image
%           imageSize - the size of the image after processing
%           featureSelect - the feature to be extracted (fourier transform, HOG, or wavelet)
% outputs:  img - the processed image
%           features - a vector containing the computed features

    img = imread(path);
    % RGB to GRAY
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    % convert to binary
    img = imbinarize(img);

    % Resize image
    img = imresize(img, imageSize);

    
    % compute the desired features and convert to a vector
    if strcmp(featureSelect,'fourier')
        fourierTrans = log(abs(fftshift(fft2(img))));
        features = fourierTrans(:)';
    elseif strcmp(featureSelect,'hog')
        features = extractHOGFeatures(img);
    elseif strcmp(featureSelect,'wavelet')
        [LoD,HiD] = wfilters('haar');
        [cA,cH,cV,cD] = dwt2(img,LoD,HiD);
        features = [cA(:)',cH(:)',cV(:)',cD(:)'];
    end