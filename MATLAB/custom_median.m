function [final_image] = custom_median(image, window_radius)
    
    % image is the image that we want to filter.
    % window_radius is the radius of the window used for the smoothing
    % process.
    % final_image is the output of the filtering process.
    
    % New image we will store our result in:
    final_image = image;

    % Size of image:
    [M, N] = size(image);

    % Loop variable to keep track of how many pixels we have added per median
    % calculation:
    loop_variable = 0;

    % The image is stored as a M x N size 2-D array of unsigned interger values
    % represting the intensity of each pixel. To implement our median filter,
    % we will move the window around in a circular search pattern.

    % Pre-allocate an array to store values in when calculating each median:
    num_entries = (window_radius*2)^2;
    temp_array = zeros(1, num_entries);
    sorted_array = zeros(1, num_entries);

    % Begin moving window
    for current_y = window_radius+1:M-window_radius
        for current_x = window_radius+1:N-window_radius
            % Calculate median value of every pixel inside the frame centered at
            % at (current_x, current_y)

            window = double(image(current_y-window_radius:current_y+window_radius, current_x-window_radius:current_x+window_radius));

            for i = 1:window_radius*2 + 1
                for j = 1:window_radius*2 + 1
                    loop_variable = loop_variable + 1;
                    temp_array(loop_variable) = window(i, j);
                end 
            end

           % Update the pixel value in the center with the median value within
           % the frame
           sorted_array = sort(temp_array);
           final_image(current_y, current_x) = median(sorted_array);
           loop_variable = 0;

        end
    end

%     figure;
%     imshow(final_image);
%     title("Custom Median Filter");

end