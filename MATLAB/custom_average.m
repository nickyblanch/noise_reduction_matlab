function [final_image] = custom_average(image, window_radius)

    % New image we will store our result in:
    final_image = image;

    % Size of image:
    [M, N] = size(image);


    % The image is stored as a M x N size 2-D array of unsigned interger values
    % represting the intensity of each pixel. To implement our median filter,
    % we will move the window around in a circular search pattern.

    temp_sum = uint32(0);

    % Begin moving window
    for current_y = window_radius+1:M-window_radius
        for current_x = window_radius+1:N-window_radius
            % Calculate mean value of every pixel inside the frame centered at
            % at (current_x, current_y)
            for i = window_radius*-1:window_radius
                for j = window_radius*-1:window_radius
                    temp_sum = temp_sum + uint32(image(current_y + i, current_x + j)); 
                end 
            end

           % Update the pixel value in the center with the median value within
           % the frame
            final_image(current_y, current_x) = temp_sum / ((2*window_radius)^2);

            % Reset temp_sum for the next loop
            temp_sum = 0;

        end
    end

%     figure;
%     imshow(final_image);
%     title("Custom Mean Filter");

end