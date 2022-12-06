function [final_image] = custom_lowpass(image, cutoff)

    % Size of image:
    [M, N] = size(image);

    % Determining digital filter:
    a = (M - 1) / 2;                                          % Half of filter length
    b = (N - 1) / 2;                                          % Half of filter height
    [n1, n2] = meshgrid(-a:a, -b:b);                          % Matrices of filter length and height
    n = sqrt(n1.^2 + n2.^2);                                  % Distance from origin of every point in the matrix                                   
    hd = (cutoff ./ (2 * pi * n)) .* besselj(1, cutoff*n);    % Impulse response of an ideal lowpass filter for n not equal to 0
    hd(a+1, b+1) = (cutoff^2)/(4*pi);                         % Impulse response of an ideal lowpass filter at n equal to 0

    % Creating our window:
    w = hamming(M) * hamming(N)';                             % 2D Hamming window

    % Obtaining h(n1, n2), our actual impulse response:
    h = hd .* w;

    % Convolve h(n1, n2) with our signal:
    final_image = filter2(image, h);
    
    % Flip the image to be in the correct orientation:
    final_image = flip(final_image, 1);
    final_image = flip(final_image, 2);
    
    % Display our result:
    final_image = uint8(real(final_image));

end