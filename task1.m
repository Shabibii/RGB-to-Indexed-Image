%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        Convert RGB to indexed
% Author:       Samir Habibi
% Rev. Date:    22/11/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; % Delete all variables.
close all; % Close all windows.
clc; % Clear command window.

% Ask user for file by presenting options with menu() command.
% Choice between 'peppers.bmp' or user to select own file.
fileChoice = menu('File', 'Girl', 'Peppers', 'Choose own');

% Use switch() to read file based on user's choice (fileChoice).
switch (fileChoice)
    case 1 % If user selects 'Peppers'.
        filename = ('girl.jpg');
        L = imread(filename);
    case 2 % If user selects 'Choose own'.
        filename = ('peppers.bmp');
        L = imread(filename);
    case 3 % If user selects 'Choose own'.
        filename = uigetfile('');
        L = imread(filename);
end % End the switch-statement after obtaining image.

% Get R, G and B value
R = L(:,:,1);
G = L(:,:,2);
B = L(:,:,3);
% Put all data in one matrix
X = double([R(:), G(:), B(:)]);

% Call function to get number of entires for the colormap/lookup table.
numberOfColours = getNumberOfColours();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function rgb2ind() is used to store a new indexed image
% and to get the specified maximum number of colours.
% The line of code below performs the minimum variance quantization
% technique for the colormap, if the image requires less colours than
% specified for 'n' in the input argument, the output image will contain
% less colours than 'n', but still all the colours of the input image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert image 'L' with dithering.
[L_indexed, colormap] = rgb2ind(L, numberOfColours);
% Convert image 'L' without dithering.
[L_indexed_no_dither, ~] = rgb2ind(L, numberOfColours, 'nodither');

% Display the RGB values for each indexed colour of the colormap in
% the Command Window.
disp(colormap);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k-means clustering is another method for quantization.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Returns cluster locations in C.
[idx, cmap] = kmeans(X, numberOfColours);
% Make sure idx and L are of the same size.
idx = reshape(idx,size(L,1),size(L,2));
% Normalize, values must be between [0 1].
cmap = cmap/255;
% Convert the label matrix idx with colormap.
L_indexedCluster = label2rgb(idx, cmap);

% The functions MC(), MCR() and checkcolours() are obtained through Github
% from author: cmanso. Available at:
% https://github.com/cmanso/MedianCut_Matlab.
L_medianCut = MC(L, numberOfColours);

figure;
% Plot original image.
subplot(2, 3, 1);
imshow(L);
title('Original Image');

% Plot indexed image after using default rgb2ind().
subplot(2, 3, 2);
imshow(L_indexed, colormap);
title('Indexed Image (rgb2ind)');

% Plot indexed image after using rgb2ind() without dithering.
subplot(2, 3, 3);
imshow(L_indexed_no_dither, colormap);
title('Indexed Image (rgb2ind) Without Dithering');

% Plot indexed image after using kmeans().
subplot(2, 3, 4);
imshow(L_indexedCluster)
title('Indexed Image (K-Means)');

% Plot indexed image after performing the median-cut technique
subplot(2, 3, 5);
imshow(L_medianCut);
title('Indexed Image (Median-Cut)');