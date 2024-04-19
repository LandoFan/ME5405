clear;
clc;
%% task 1
% load in the original image and convert to binary
input_image = imread('hello_world.jpg');
% input_image = im2bw(input_image,0.5);
figure(1);
imshow(input_image);

axis on;
axis image;
title('original_image')

[rows, columns] = size(input_image); 
fprintf('rows:%d, columns:%d\n', rows, columns);
%% Task2

% Get the middle line image
middle_line_image = get_mid_line(input_image);

% Display the middle line image
figure(2);
imshow(middle_line_image);
title('middle_line_image');
%% Task3

% Get the histogram of the middle line image
histogram = gethistogram(middle_line_image);

% Display the histogram of the middle line image
figure(3);
bar(histogram);
title("histogram of middle_line_image");
xlabel("Gray Level");
ylabel("Frequency");

% Get the binary image
threshold = 90; % Threshold can be adjusted
binary_image = get_bi_image(middle_line_image,threshold);

% Display the binary image
figure(4);
imshow(binary_image);
title('binary_image');

%%  task 4
% obtain a one-pixel thin image of the objects
% middle_line_image = im2bw(middle_line_image,0.5);
task_3_image = one_pixel(binary_image);
figure(5);
imshow(task_3_image);
%% task 5
% obtain the outlines of the objects present in the image
task_4_image = get_outline(binary_image);
figure(6);
imshow(task_4_image);
%% task 6 
% label different character
figure(7)
[label_image,num] = segment(binary_image);
img_rgb = label2rgb(label_image, 'jet', [0 0 0], 'shuffle');  % jet colormap 
imshow(img_rgb,'InitialMagnification','fit');
%saveas(gcf, sprintf('figure7.jpg')); 

%seperate each character
[img_num, s] = img_seperate(label_image);
s=s(1:length(s));
for i = 1 : length(s)
    s(i).image=1 - imbinarize(imresize(s(i).image,[128,128]));
    figure(7+i);

    imshow(s(i).image, [], 'InitialMagnification','fit');
    %saveas(gcf, sprintf('figure_%d.jpg', i)); 
end

