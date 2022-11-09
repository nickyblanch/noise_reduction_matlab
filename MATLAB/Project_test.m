%% Author: Nicolas Blanchard

%% Loading our image
image = imread('300.png');
image = rgb2gray(image);

%% Obtaining results
matlab_median = matlab_median(image);

custom_median = custom_median(image, 5);

custom_average = custom_average(image);

[custom_lowpass, filter_mask, fft] = custom_lowpass(image, 150);

custom_adaptive = custom_adaptive(image, 5, 200);

gaussian_approach = gaussian_approach(image, 5, 15);

%% Display results
montage([image matlab_median custom_median]);
%% Calculating SNR
original_image = imread('ambulance_no_noise.png');
noisy_image = imread('ambulance_noise.png');