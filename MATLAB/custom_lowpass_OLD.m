function [final_image, filter_mask, fourier_transformed_image] = custom_lowpass(image, cutoff)

    % Size of image:
    [M, N] = size(image);

    % Making our digital filter:
    a = 0:(M-1);                                        % Create a vector from 0 to M-1
    position_x = find(a>M/2);
    a(position_x) = a(position_x) - M;                  % Shift that vector so that it is centered at the origin
    b = 0:(N-1);                                        % Create a vector from 0 to N-1
    position_y = find(b>N/2);
    b(position_y) = b(position_y) - N;                  % Shift that vector so that it is centered at the origin
    [B, A] = meshgrid(b, a);                            % Create a mesh grid using our vectors. This essentially creates matrices A and B which are composed of repeating vectors a and b.
    distance = sqrt(A.^2 + B.^2);                       % To eventually make our mask, we will need to know the distance of each point from the origin (DC region). This calculates distance.
    filter_mask = double(distance <= cutoff);           % Now, anywhere with a distance less than our cutoff gets kept. This creates a disk of radius 'cutoff'.
    
    % Getting our image into the frequency domain
    fourier_transformed_image = fft2(double(image));    % Create the 2D fourier transform of our image so we can filter it in the frequency domain.

    % Applying filter to image
    result = filter_mask.*fourier_transformed_image;    % Convolve our filter mask with the fourier transformed image to remove eveyrthing outside of the mask.

    % Result
    final_image = uint8(real(ifft2(double(result))));   % Inverse fourier transform to re-create the image

    %imshow(final_image, []);                           % If we want to use imshow instead of imshowpair, we need to shift the display range so that the smallest image intensity is 0 and the largest image instensity is 1.

end