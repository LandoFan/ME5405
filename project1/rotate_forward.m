function [rotated_image] = rotate_forward(binary_figure,degree)

    [row,column] = size(binary_figure);

    rotated_row = ceil(abs(row*cosd(degree)) + abs(column*sind(degree)));
    rotated_column = ceil(abs(row*sind(degree))+abs(column*cosd(degree)));

    rotation_matrix = [cosd(degree) -sind(degree) 0;
                       sind(degree) cosd(degree) 0;
                       0 0 1;];
    coordinate_trans = [1  0 0;
                       0 -1 0;
                       -0.5*row 0.5*column 1];
    invcoordinate_trans = [1 0 0;
                          0 -1 0;
                          0.5*rotated_row 0.5*rotated_column 1];

    rotated_image = zeros(rotated_row,rotated_column);

    for i = 1 : row
        for j = 1 : column
              coordinate = [i j 1]*coordinate_trans*rotation_matrix*invcoordinate_trans;
              n = round(coordinate(1));
              m = round(coordinate(2));

              if n > rotated_column
                  n = rotated_column;
              elseif n < 1
                  n = 1;
              end
              
              if m > rotated_row
                  m = rotated_row;
              elseif m < 1
                  m = 1;
              end

              rotated_image(n,m) = binary_figure(i,j);

       end
    end
end

