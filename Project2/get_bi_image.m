function binary_image = task3(middle_line_image,threshold)

  [rows, columns] = size(middle_line_image);  
  columns = columns/3;
  binary_image = zeros(rows, columns);

  for i = 1:rows
      for j = 1:columns
          gray_value = middle_line_image(i, j);
        
          if gray_value > threshold
              binary_image(i, j) = 1;
          else
              binary_image(i, j) = 0;
          end
      end
  end
    
end