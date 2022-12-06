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
    for j=1:10
        [unused(i, j) results_median(i, j)] = psnr(original_image, custom_adaptive(noisy_image, window_size(i), alpha(j)));
    end
end

figure;
[X,Y] = meshgrid(1:10, 0:100:900);
surf(X, Y, results_median);
title("Edge Preserving Local Median - SNR vs Window Radius & Alpha");
xlabel("Window Radius (pixels)");
ylabel("Alpha");
zlabel("SNR (dB)");
ylim([0 900]);
xlim([1 10]);
zlim([0 25]);