clear all
clc

%% Read file data

fileID = fopen('chromo.txt', 'r');
lf = char(10); 
cr = char(13); 
char_data = fscanf(fileID, [cr lf '%c'], [64, 64]);
char_data = char_data';
fclose(fileID);

%% Task 1

% Display the original image on screen
char_map = '0123456789ABCDEFGHIJKLMNOPQRSTUV';
gray_image = zeros(64, 64, 'uint8'); 

for i = 1:64
    for j = 1:64
        char_idx = strfind(char_map, char_data(i , j));
        gray_image(i, j) = uint8((char_idx - 1) * (255 / 31));
    end
end

figure(1)
imshow(gray_image);
title("Original Image");

%% Task 2

% Draw picture histogram
drawhistogram(gray_image)

threshold = 170; % Threshold can be adjusted
binary_image = zeros(64, 64);

% Threshold the image and convert it into binary image
for i = 1:64
    for j = 1:64
        gray_value = gray_image(i, j);
        
        if gray_value > threshold
            binary_image(i, j) = 1;
        else
            binary_image(i, j) = 0;
        end
    end
end

figure(3)
imshow(binary_image);
title("Binary Image");

%% Task 3

% Obtain a one-pixel thin image of the objects
task_3_image = ~one_pixel(~binary_image);

figure(4);
imshow(task_3_image);
title("One-pixel Thin Image of the Objects");

%% Task 4

% Obtain the outlines of the objects present in the image
task_4_image = get_outline(binary_image);

figure(5);
imshow(task_4_image);
title("Outlines of the Objects");

%% Task 5

% Label the different objects

figure(6)

label_image_4 = label_4(binary_image);
subplot(1,2,1)
img_rgb = label2rgb(label_image_4, 'jet', [0 0 0], 'shuffle');  % jet colormap 
imshow(img_rgb,'InitialMagnification','fit');
title("Two Pass Method with 4 Connectivity")

label_image_8 = label_8(binary_image);
subplot(1,2,2)
img_rgb = label2rgb(label_image_8, 'jet', [0 0 0], 'shuffle');  % jet colormap 
imshow(img_rgb,'InitialMagnification','fit');
title("Two Pass Method with 8 Connectivity")

%% Task 6

% Rotate the original image by 30 degrees, 60 degrees and 90 degrees respectively

figure(7)
subplot(3,1,1)
rotated_image = rotate_forward(gray_image,30);
imshow(rotated_image, [], 'InitialMagnification','fit')
title("Forward Mapping with 30 Degreee Rotation")

subplot(3,1,2)
rotated_image = rotate_forward(gray_image,60);
imshow(rotated_image, [], 'InitialMagnification','fit')
title("Forward Mapping with 60 Degreee Rotation")

subplot(3,1,3)
rotated_image = rotate_forward(gray_image,90);
imshow(rotated_image, [], 'InitialMagnification','fit')
title("Forward Mapping with 90 Degreee Rotation")

figure(8)
% https://blog.csdn.net/lkj345/article/details/50555870 rotation principle
subplot(3,2,1)
[rotated_image_nni,rotated_image_bi] = rotate_backward(gray_image,30);
imshow(rotated_image_nni, [], 'InitialMagnification','fit')
title("Backward Mapping with 30 Degreee Rotation")
subplot(3,2,2)
imshow(rotated_image_bi, [], 'InitialMagnification','fit')


subplot(3,2,3)
[rotated_image_nni,rotated_image_bi] = rotate_backward(gray_image,60);
imshow(rotated_image_nni, [], 'InitialMagnification','fit')
title("Backward Mapping with 60 Degreee Rotation")
subplot(3,2,4)
imshow(rotated_image_bi, [], 'InitialMagnification','fit')

subplot(3,2,5)
[rotated_image_nni,rotated_image_bi] = rotate_backward(gray_image,90);
imshow(rotated_image_nni, [], 'InitialMagnification','fit')
title("Backward Mapping with 90 Degreee Rotation")
subplot(3,2,6)
imshow(rotated_image_bi, [], 'InitialMagnification','fit')




