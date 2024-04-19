function output_image = one_pixel(input_image)
% this function takes a binary image as input, and uses the Zhang-Suen
% thinning algorithm to output a one-pixel thin image of the objects
% a description of the algorithm can be found at
% https://rosettacode.org/wiki/Zhang-Suen_thinning_algorithm#C

    % initialize intermediate and output image matrices
    [num_row,num_col] = size(input_image);
    output_image = input_image;
    temp = output_image;
    
    complete = false;
    
    % this process will run until it stops making changes to the image
    while ~complete
        complete = true;
        for step = 1:2
            % evaluate all pixels in the image (excluding border pixels) and
            % their corresponding 8-neighbourhoods
            for row = 2:num_row - 1
                for col = 2:num_col - 1
                    neighbourhood = output_image(row-1:row+1,col-1:col+1);
                    if step == 1
                        if test_pixel_1(neighbourhood) == true
                            temp(row,col) = 0;
                            complete = false;
                        end
                    else
                        if test_pixel_2(neighbourhood) == true
                            temp(row,col) = 0;
                            complete = false;
                        end
                    end
                end
            end
            output_image = temp;
        end
    end

end


function num_transitions = count_transitions(neighbourhood)
% this function takes a pixel and its 8-neighbourhood (a 3x3 matrix) as input
% and outputs the number of transitions from black to white in that
% neighbourhood

    sequence = [neighbourhood(1,:) neighbourhood(2:3,3).' flip(neighbourhood(3,1:2)) flip(neighbourhood(1:2,1).')]; % arrange the neighbourhood in clockwise order
    num_transitions = sum(diff(sequence) > 0); % count the number of transitions from 0 to 1
end

function num_white = count_white(neighbourhood)
% this function takes a pixel and its 8-neighbourhood (a 3x3 matrix) as input
% and outputs the number of white pixels in that neighbourhood

    num_white = nnz(neighbourhood) - neighbourhood(2,2);
end

function satisfies_requirements = test_pixel_1(neighbourhood)
% this function takes a pixel and its 8-neighbourhood (a 3x3 matrix) as
% input and outputs whether or not the pixel satisfies the requirements of
% pass 1 of the algorithm

    num_white = count_white(neighbourhood);
    satisfies_requirements = (neighbourhood(2,2) == 1)... 
        && (num_white >= 2 && num_white <= 6)...
        && (count_transitions(neighbourhood) == 1)...
        && (neighbourhood(1,2) == 0 || neighbourhood(2,3) == 0 || neighbourhood(3,2) == 0)...
        && (neighbourhood(2,3) == 0 || neighbourhood(3,2) == 0 || neighbourhood(2,1) == 0);
end

function satisfies_requirements = test_pixel_2(neighbourhood)
% this function takes a pixel and its 8-neighbourhood (a 3x3 matrix) as
% input and outputs whether or not the pixel satisfies the requirements of
% pass 2 of the algorithm

    num_white = count_white(neighbourhood);
    satisfies_requirements = (neighbourhood(2,2) == 1)... 
        && (num_white >= 2 && num_white <= 6)...
        && (count_transitions(neighbourhood) == 1)...
        && (neighbourhood(1,2) == 0 || neighbourhood(2,3) == 0 || neighbourhood(2,1) == 0)...
        && (neighbourhood(1,2) == 0 || neighbourhood(3,2) == 0 || neighbourhood(2,1) == 0);
end

