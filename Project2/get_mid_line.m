function middle_line_image = task2(original_image)

    [rows, columns] = size(original_image);
    top_row = rows/3; 
    bottom_row = rows*2/3; 
    middle_line_image = original_image(top_row:bottom_row, :, :);

end