%% Author: Nicolas Blanchard
% Course: ECE 529 Digital Signal Processing
% Instructor: Prof. Jeffrey Rodriguez
% Term: Fall 2022
% Desription:
%             This file is the culmination of my work for the ECE 529 course project. It
%             implements a variety of image smoothing techniques to remove grain from
%             film images. The dependencies are:
%
%             * Matlab Image Processing Toolbox
%             * 'custom_median.m'
%             * 'custom_lowpass.m'
%             * 'custom_average.m'
%             * 'custom_adaptive.m'
%             * custom_adaptive_multiplicative.m'
%
%             Contact Nick at (520) 834-3191 or nickyblanch@arizona.edu with questions
%             about implementation.

%% Filter Parameters and Choosing Source Image
clear;
clc;
image = imread('../images/300_cropped_bw.png');
image = im2gray(image);

% Window size for filters:
window_size = 7;

% Sensitivity for Prewitt Kernel based edge detection:
alpha = 900;
multiplicative_alpha = 20;

% Cutoff frequency for lowpass filter (rad):
cutoff_freq = 0.4;


%% Applying Filters
matlab_median = matlab_median(image);

custom_median = custom_median(image, window_size);

custom_average = custom_average(image, window_size);

custom_lowpass = custom_lowpass(image, cutoff_freq);

custom_adaptive = custom_adaptive(image, window_size, alpha);

custom_adaptive_multiplicative = custom_adaptive_multiplicative(image, window_size, multiplicative_alpha);


%% Displaying results
results = {image matlab_median custom_median custom_average custom_lowpass custom_adaptive custom_adaptive_multiplicative};


fig = figure(); 
titles = ["Original Image", "Matlab Median Filter", "Custom Median Filter", "Custom Average Filter", "Custom Lowpass Filter", "Custom Adaptive Filter", "multiplicative Approach"];
% tlo = tiledlayout(fig,4,2);
% tlo.TileSpacing='tight';
for i = 1:numel(results)
%     ax = nexttile(tlo); 
%     imshow(results{i},'Parent',ax)
    figure;
    imshow(results{i});
    % subplot(2, 4, i), imshow(results{i});
    % title(titles(i), 'FontSize', 8);
    imwrite(results{i}, titles(i)+ "_7px" + ".png");
end
