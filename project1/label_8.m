function label_image = label_8(binary_image)
    [row , column] = size(binary_image);
    % connectivity = 8
    label_num = 1;
    label_image = zeros(row,column);
    
    % label the first row
    for j = 1 : column
        if binary_image(1,j) ~= 1
            if j==1
                label_image(1,j) = label_num;
            else
                if binary_image(1,j)~=binary_image(1,j-1)
                    label_num = label_num + 1;
                    label_image(1,j) = label_num;
                else
                    label_image(1,j) = label_num;

                end
            end
        end
    end
    
    % label other rows
    for i = 2 : row
        for j = 1 : column
            if binary_image(i,j) ~= 1
                if j == 1
                    if binary_image(i,j)==binary_image(i-1,j)
                        label_image(i,j) = label_image(i-1,j);
                    elseif binary_image(i,j)==binary_image(i-1,j+1)
                        label_image(i,j) = label_image(i-1,j+1);
                    else
                        label_num = label_num + 1;
                        label_image(i,j) = label_num;
                        
                    end
                else

                    flag = [];
                    t = 1;
                    if binary_image(i,j) == binary_image(i-1,j-1)
                        flag(t) = label_image(i-1,j-1);
                        t = t + 1;
                    end
                 
                    if binary_image(i,j)==binary_image(i-1,j)
                        flag(t) = label_image(i-1,j);
                        t = t + 1;
                    end

                    if j < 64 && binary_image(i,j)==binary_image(i-1,j+1)
                        flag(t) = label_image(i-1,j);
                        t = t + 1;
                    end

                    if binary_image(i,j)==binary_image(i,j-1)
                        flag(t) = label_image(i-1,j);
                        t = t + 1;
                    end

                    if isZeroMatrix(flag)
                        label_num = label_num + 1;
                        label_image(i,j) = label_num;
                    else
                        flag = nonzeros(flag);
                        label_image(i,j) = min(flag);
                    end
                end
            end
        end
    end

    % second pass
   [len, width] = find( label_image ~= 0 ); % point coordinate (row(i), col(i))   
   for k = 1 : row
        for i = 1:length(len)
            if len(i)-1 > 0
                up = len(i)-1;
            else
                up = len(i);
            end
     
            if len(i)+1 <= row
                down = len(i)+1;
            else
                down = len(i);
            end
     
            if width(i)-1 > 0
                left = width(i)-1;
            else
                left = width(i);
            end
     
            if width(i)+1 <= column
                right = width(i)+1;
            else
                right = width(i);
            end
     
            % 8 connectivity
            connection = label_image(up:down, left:right);
    
            if ~isZeroMatrix(connection)
                connection = nonzeros(connection);
                label_image(len(i),width(i)) = min(connection);
            end

        end
   end

    u_label = unique(label_image);     % get all the unique label values in out_img
    for i = 2:length(u_label)
        label_image(label_image == u_label(i)) = i-1;  % reset the label value: 1, 2, 3, 4......
    end
    
    label_num = unique(label_image(label_image > 0));
    num = numel(label_num);  % numel function gives the pixel numbers
end


function is_all_zeros = isZeroMatrix(matrix)
    is_all_zeros = all(matrix(:) == 0);
end

