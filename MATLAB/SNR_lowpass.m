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
cutoff_freq = 0:.1:.9;


%% Calculating SNR


for i = 1:10
    image = custom_lowpass(noisy_image, cutoff_freq(i));
    [unused(i) results_lp(i)] = psnr(original_image, image);
end

figure;
plot(0:0.1:0.9, results_lp);
title("Lowpass Filter - SNR vs Cutoff");
xlabel("Cutoff");
ylabel("SNR (dB)");
ylim([0 25]);
xlim([0 180]);