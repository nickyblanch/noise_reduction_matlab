%% Author: Nicolas Blanchard

%% Loading our image
clear;
clc;
image = imread('../images/300_cropped.png');
image = rgb2gray(image);

%% Obtaining results
matlab_median = matlab_median(image);

custom_median = custom_median(image, 5);

custom_average = custom_average(image, 5);

[custom_lowpass, filter_mask, fft] = custom_lowpass(image, 50);

custom_adaptive = custom_adaptive(image, 5, 200);

gaussian_approach = gaussian_approach(image, 5, 15);

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
% %% Calculating SNR
% original_image = imread('../images/ambulance_no_noise.png');
% noisy_image = imread('../images/ambulance_noise.png');