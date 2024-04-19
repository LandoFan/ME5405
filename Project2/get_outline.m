function output_image = get_outline(input_image)
% this function takes a binary image as input, and outputs an image showing
% the outlines of the objects present in the original image

    % initialize intermediate and output image matrices
    [num_row,num_col] = size(input_image);
    intermediate_1 = zeros(num_row,num_col);
    intermediate_2 = zeros(num_row,num_col);
    output_image = zeros(num_row,num_col);
    
    % simulatenously run pass 1 and pass 2
    for row = 1:num_row-1
        for col = 2:num_col
            % check for pixel value difference with the column to the left
            if (input_image(row,col) ~= input_image(row,col-1))
                intermediate_1(row,col) = 1;
            end
            % check for pixel value difference with the row underneath
            if (input_image(row,col) ~= input_image(row+1,col))
                intermediate_2(row,col) = 1;
            end
        end
    end
    
    % merge the two intermediate images
    output_image = intermediate_1 | intermediate_2;