function histogram = gethistogram(image)

  histogram = zeros(1, 256);

  [rows, columns] = size(image);
  columns = columns/3;

  for i = 1:rows
      for j = 1:columns
          pixel_value = image(i, j) + 1; 
          histogram(pixel_value) = histogram(pixel_value) + 1;
      end
  end

end