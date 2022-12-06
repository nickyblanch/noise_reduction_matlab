function [final_image, filter_mask, fourier_transformed_image] = custom_lowpass_TEST(image, cutoff)

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
    % figure; imagesc(abs(fftshift(filter_mask)));
    % title("Mask that will be used to only allow low frequency to pass");
    % ylim([1060 1110]);
    % xlim([1870 1970]);

    fourier_transformed_image = fft2(double(image));    % Create the 2D fourier transform of our image so we can filter it in the frequency domain.
    % figure; imagesc(abs(fftshift(fourier_transformed_image)));
    % title("Frequency spectrum of image");
    % ylim([1060 1110]);
    % xlim([1870 1970]);

    result = filter_mask.*fourier_transformed_image;    % Convolve our filter mask with the fourier transformed image to remove eveyrthing outside of the mask.

    final_image = uint8(real(ifft2(double(result))));          % Inverse fourier transform to re-create the image

    % figure;
    % imshowpair(image, final_image, 'montage');          % Compare the results to the original image
    % title("Original Image versus Custom Lowpass Filter");
    %figure;
    %imshow(final_image, []);                           % If we want to use imshow instead of imshowpair, we need to shift the display range so that the smallest image intensity is 0 and the largest image instensity is 1.

end