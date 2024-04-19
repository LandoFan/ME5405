function [rotatedImg_nni, rotatedImg_bi] = rotate_backward(binary_figure, degree)
    
    row = size(binary_figure, 1);
    column = size(binary_figure, 2);

    
    %   the size of figure after rotation
    rotated_row = ceil(abs(row*cosd(degree)) + abs(column*sind(degree)));
    rotated_column = ceil(abs(column*cosd(degree)) + abs(row*sind(degree)));
    
    rotatedImg_nni = zeros(rotated_row, rotated_column);
    rotatedImg_bi = zeros(rotated_row, rotated_column);
    
    rotation_matrix = [cosd(degree) sind(degree) 0;
                       -sind(degree) cosd(degree) 0;
                       0 0 1;];
    coordinate_trans = [1  0 0;
                       0 -1 0;
                       -0.5*rotated_row 0.5*rotated_column 1];
    invcoordinate_trans = [1 0 0;
                          0 -1 0;
                          0.5*row 0.5*column 1];
    
    %   reverse mapping
    for i = 1 : rotated_column   %x
        for j = 1 : rotated_row   %y

            coordinate = [i j 1]*coordinate_trans*rotation_matrix*invcoordinate_trans;
            n = round(coordinate(1));
            m = round(coordinate(2));
            
            % overflow
            if m < 1 || n < 1 || m > row || n > column
                rotatedImg_nni(j,i) = 0;
                rotatedImg_bi(j,i) = 0;
            else
                % nearest neighbor interpolation
                rotatedImg_nni(j,i) = binary_figure(m,n);
    
                % bilinear interpolation
                %reference https://blog.csdn.net/bby1987/article/details/105851870
                left = floor(n);
                right = ceil(n);
                top = floor(m);
                bottom = ceil(m);
    
                a = n - left;
                b = m - top;
                rotatedImg_bi(j,i) = (1-a)*(1-b)*binary_figure(top,left) + ...
                                     a*(1-b)*binary_figure(top,right) + ...
                                     (1-a)*b*binary_figure(bottom,left) + ...
                                     a*b*binary_figure(bottom,right);
            end
        end
    end
    
    
end
