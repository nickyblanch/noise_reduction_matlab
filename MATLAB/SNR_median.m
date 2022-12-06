%% Filter Parameters and Choosing Source Image
clear;
clc;
original_image = imread('../images/ambulance_cropped_no_noise_bw.png');
original_image = rgb2gray(original_image);

noisy_image = imread('../images/ambulance_cropped_noisy_bw.png');
noisy_image = rgb2gray(noisy_image);

% Window size for filters:
window_size = 1:10;

% Sensitivity for Prewitt Kernel based edge detection:
alpha = 0:100:900;
multiplicative_alpha = 0:3:27;

% Cutoff frequency for lowpass filter
cutoff_freq = 0:20:200;


%% Calculating SNR


for i = 1:10
    [unused(i) results_median(i)] = psnr(original_image, custom_median(noisy_image, window_size(i)));
end

figure;
plot(1:10, results_median);
title("Local Median - SNR vs Window Radius");
xlabel("Window Radius (pixels)");
ylabel("SNR (dB)");
ylim([0 25]);
xlim([1 10]);