%% Initialization

clc
clear
close all

%% Reading the Original Image

Orig_Image = imread('Lena.tif');
% Orig_Image = imread('Peppers.tif');
% Orig_Image = imread('boat.tif');
% Orig_Image = imread('bridge.tif');

%% Applying the Salt-and-Pepper Noise

Noise_Density = 0.8;

Noisy_Image = imnoise(Orig_Image, 'salt & pepper', Noise_Density);

%% Impulse Detection

tic

Mask = Impulse_Detector(Noisy_Image);

%% Image Restoration

Restored_Image = EWA_Filter(Noisy_Image, Mask);

Time_Elapsed = toc;

%% PSNR Value

PSNR = 10*log10( 255^2 / mean(( double(Restored_Image(:)) - double(Orig_Image(:)) ).^2 ));

%% Displaying Images

figure(1); imshow(Orig_Image); title('Original Image')

figure(2); imshow(Noisy_Image); 
title(['Noisy Image, ' num2str(100*Noise_Density) '% Salt and Pepper Noise'])

figure(3); imshow(Restored_Image); 
title(['Restored Image, PSNR = ' num2str(floor(PSNR*100)/100) ' dB' ...
    ', Time = '  num2str(floor(Time_Elapsed*100)/100) ' Seconds'])
