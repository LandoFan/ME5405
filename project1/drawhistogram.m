function drawImage = drawhistogram(gray_image)

    histogram = zeros(1, 256);

    for i = 1:64
        for j = 1:64
            pixel_value = gray_image(i, j) + 1; 
            histogram(pixel_value) = histogram(pixel_value) + 1;
        end
    end

    figure(2);
    bar(histogram);
    title("Histogram of the Image");
    xlabel("Gray Level");
    ylabel("Frequency");

end