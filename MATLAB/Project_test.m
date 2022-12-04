%% Author: Nicolas Blanchard

%% Loading our image
clear;
clc;
image = imread('../images/ambulance_cropped_noisy_bw.png');
image = rgb2gray(image);

%% Obtaining results
matlab_median = matlab_median(image);

custom_median = custom_median(image, 5);

custom_average = custom_average(image, 5);

[custom_lowpass, filter_mask, fft] = custom_lowpass(image, 50);

custom_adaptive = custom_adaptive(image, 4, 250);

gaussian_approach = gaussian_approach(image, 5, 15);

figure;
imshowpair(image, custom_adaptive, 'montage');

%% Display results
results = {image matlab_median custom_median custom_average custom_lowpass custom_adaptive gaussian_approach};


fig = figure(); 
titles = ["Original Image", "Matlab Median Filter", "Custom Median Filter", "Custom Average Filter", "Custom Lowpass Filter", "Custom Adaptive Filter", "Gaussian Approach"];
% tlo = tiledlayout(fig,4,2);
% tlo.TileSpacing='tight';
for i = 1:numel(results)
%     ax = nexttile(tlo); 
%     imshow(results{i},'Parent',ax)
    subplot(2, 4, i), imshow(results{i});
    title(titles(i), 'FontSize', 8);
end

%% Calculating SNR
original_image = imread('../images/ambulance_cropped_no_noise_bw.png');
original_image = rgb2gray(original_image);

noisy_image = imread('../images/ambulance_cropped_noisy_bw.png');
noisy_image = rgb2gray(noisy_image);

matlab_median = matlab_median(noisy_image);

custom_median = custom_median(noisy_image, 5);

custom_average = custom_average(noisy_image, 5);

[custom_lowpass, filter_mask, fft] = custom_lowpass(noisy_image, 50);

custom_adaptive = custom_adaptive(noisy_image, 4, 250);

gaussian_approach = gaussian_approach(noisy_image, 5, 15);

SNR_pre_results = {original_image noisy_image matlab_median custom_median custom_average custom_lowpass custom_adaptive gaussian_approach};

for i = 1:numel(SNR_pre_results)
    [SNR_post_results_psnr(i) SNR_post_results_snr(i)] = psnr(original_image, SNR_pre_results{i});
end

SNR_post_results_snr
SNR_post_results_psnr