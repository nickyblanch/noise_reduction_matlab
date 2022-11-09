function [final_image] = custom_adaptive(image, window_radius, alpha)

    % image is the image that we want to filter.
    % window_radius is the radius of the window used for the smoothing
    % process.
    % alpha is the cutoff value for detecting an edge in the window.
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

    % To determine if an edge is present, we utilize the Prewitt kernel
    % in the x-direction and y-direction, for a window radius of 5 pixels.
    starting_vec_x = [-1 zeros(1, 2*window_radius - 1) 1];        
    prewitt_x = repmat(starting_vec_x, 2*window_radius+1, 1);

    starting_vec_y = [-1; zeros(2*window_radius - 1, 1); 1];
    prewitt_y = repmat(starting_vec_y, 1, 2*window_radius+1);

    % ALPHA is the parameter that controls the edge detection sensitivity.

    % Begin moving window
    for current_y = window_radius+1:M-window_radius
        for current_x = window_radius+1:N-window_radius
            % Calculate median value of every pixel inside the frame centered at
            % at (current_x, current_y)

            window = double(image(current_y-window_radius:current_y+window_radius, current_x-window_radius:current_x+window_radius));

            % Now, we will apply the Prewitt kernels in the x and y directions
            % to detect if an edge is present.

            % If there is not a large difference in pixel values between the two
            % sides or top and bottom, then we are not on an edge:
            if ( abs(sum(prewitt_x .* window, 'all')) < alpha && abs(sum(prewitt_y .* window, 'all')) < alpha )
                for i = 1:window_radius*2+1
                    for j = 1:window_radius*2+1
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
           % Otherwise, if there is a large difference in pixel values between
           % the two sides or top and bottom, then we are on an edge and no
           % smoothing should occur:
        end
    end

%     figure;
%     imshowpair(image, final_image, 'montage');
%     title("Original Image versus Custom Adaptive Median Filter");

end