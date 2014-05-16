function Restored_Image = EWA_Filter(Noisy_Image, Mask)
% This function performs image restoration using the EWA filter

Noisy_Image = double(Noisy_Image);

Noisy_Image(~Mask) = 0;

%% Initial Interpolation

[DM, Neighbors] = bwdist(Noisy_Image);

Init_Image = Noisy_Image(Neighbors);

%% Weights

h = ones(3);

weights_known = 9 ./ conv2(double(Mask), h, 'same');
weights_noisy = 1 ./ (double(DM) + 1);

weights = weights_noisy;
weights(Mask) = weights_known(Mask);

%% Image Restoration

Restored_Image = conv2(Init_Image .* weights, h, 'same') ./ conv2(weights, h, 'same');

Restored_Image(Mask) = Noisy_Image(Mask);

Restored_Image = uint8(Restored_Image);

