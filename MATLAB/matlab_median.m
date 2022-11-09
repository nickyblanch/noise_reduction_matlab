function [final_image] = matlab_median(image)

    final_image = medfilt2(image, [11 11]);
%     figure;
%     imshow(final_image);
%     title("Matlab Median Filter");

end