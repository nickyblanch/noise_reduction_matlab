%% Filter Parameters and Choosing Source Image
clear;
clc;
original_image = imread('../images/ambulance_cropped_no_noise_bw.png');
original_image = rgb2gray(original_image);

noisy_image = imread('../images/ambulance_cropped_noisy_bw.png');
noisy_image = rgb2gray(noisy_image);

% Window size for filters:
window_size = 1;

% Sensitivity for Prewitt Kernel based edge detection:
alpha = 250;
multiplicative_alpha = 15;

% Cutoff frequency for lowpass filter
cutoff_freq = 50;


%% Calculating SNR

matlab_median = matlab_median(noisy_image);

custom_median = custom_median(noisy_image, window_size);

custom_average = custom_average(noisy_image, window_size);

[custom_lowpass, filter_mask, fft] = custom_lowpass(noisy_image, cutoff_freq);

custom_adaptive = custom_adaptive(noisy_image, window_size, alpha);

custom_adaptive_multiplicative = custom_adaptive_multiplicative(noisy_image, window_size, multiplicative_alpha);

SNR_pre_results = {original_image noisy_image matlab_median custom_median custom_average custom_lowpass custom_adaptive custom_adaptive_multiplicative};

for i = 1:numel(SNR_pre_results)
    [SNR_post_results_psnr(i) SNR_post_results_snr(i)] = psnr(original_image, SNR_pre_results{i});
end

SNR_post_results_snr
SNR_post_results_psnr