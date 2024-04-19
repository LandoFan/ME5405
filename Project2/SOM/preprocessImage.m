function imgVector = preprocessImage(img, imageSize)

    % Image normalization
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    img = imresize(img, imageSize);

    imgVector = img(:)';
    imgVector = double(imgVector)/255;

    imgVector = imgVector';
    
end