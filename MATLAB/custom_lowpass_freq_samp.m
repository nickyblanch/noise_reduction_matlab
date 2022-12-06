function [final_image] = custom_lowpass_freq_samp(image, cutoff)

    % Size of image:
    [M, N] = size(image);

    % Making our desired frequency response for an IDLP:
    a = 0:(M-1);                                          % Create a vector from 0 to M-1.
    position_x = find(a>M/2);
    a(position_x) = a(position_x) - M;                    % Shift that vector so that it is centered at the origin.
    b = 0:(N-1);                                          % Create a vector from 0 to N-1.
    position_y = find(b>N/2);
    b(position_y) = b(position_y) - N;                    % Shift that vector so that it is centered at the origin.
    [B, A] = meshgrid(b, a);                              % Create a mesh grid using our vectors. This essentially creates matrices A and B
                                                          % which are composed of repeating vectors a and b.
    distance = sqrt(A.^2 + B.^2);                         % To eventually make our mask, we will need to know the distance of each point from
                                                          % the origin. This line calculates distance.
    Hd = double(distance <= cutoff);                      % Now, anywhere with a distance less than our cutoff gets kept. This creates a disk of radius 'cutoff'.
    

    % Obtaining hd(n1, n2), the desired impulse response:
    hd = ifft2(Hd);                                         % Inverse Fourier Transform our frequency response

    % Creating our window
    w = hamming(M) * hamming(N)';                           % 2D Hamming window

    % Obtaining h(n1, n2), our actual impulse response:
    h = hd .* w;

    % Convolve h(n1, n2) with our signal:
    final_image = conv2(image, h);

    % imshow(real(final_image(1:M, 1:N)), []);
    % imshow(final_image(1:885, 1:885), []);

%     % Getting our image into frequency domain
%     fourier_transformed_image = fft2(double(image), 2*M, 2*N);      % Create the 2D fourier transform of our image so we can filter it in the frequency domain.
%     
%     % Applying filter to image
%     result = filter_mask.*fourier_transformed_image;                % Convolve our filter mask with the fourier transformed image to remove eveyrthing outside of the mask.
% 
%     % Result
%     final_image = uint8(real(ifft2(double(result))));               % Inverse fourier transform to re-create the image

end