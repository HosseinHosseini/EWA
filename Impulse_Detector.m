function Mask = Impulse_Detector(Noisy_Image)
% This function performs impulse detection and outputs the binary mask matrix
% which is zero in the corresponding position of the corrupted pixels.

Noisy_Image = double(Noisy_Image);

%% Detecting the Impulse Values

Nmin = min(Noisy_Image(:));
Nmax = max(Noisy_Image(:));

%% Constructiog the Set of Suspicious Pixels

Set_Nmin = (Noisy_Image == Nmin);
Set_Nmax = (Noisy_Image == Nmax);

Set_Noise = Set_Nmin | Set_Nmax;

%% Determining the Window Size

p = mean(Set_Noise(:));

w = 2*floor( ceil( sqrt(1 + 5/(1-p)) ) / 2 ) + 1;

%% Discriminating the Uncorrupted Pixels which have an Impulse Value

Cmin = conv2(double(Set_Nmin), ones(w), 'same');
Cmax = conv2(double(Set_Nmax), ones(w), 'same');

Set_Data1 = ((Cmin + Cmax) == w^2);

Set_Data2 = (Set_Nmin & (Cmax <= Cmin/3)) | (Set_Nmax & (Cmin <= Cmax/3));

%% The Mask Matrix corresponding to the Corrupted Pixels

Mask = ~Set_Noise | (Set_Data1 & Set_Data2);

