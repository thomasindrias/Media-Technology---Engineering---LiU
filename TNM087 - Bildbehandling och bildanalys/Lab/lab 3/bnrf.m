function H = bnrf(f, uk, vk, D0, n)
%Generates a Gaussian low-pass filter with the same size as the input image
%INPUT:
%f = input image for size control.
%uk, vk = position of the peak relative to the center of the spectrum
%n = number of pair of notches
%OUTPUT:
%lp = gaussian low pass filter

%% Size 
[P, Q] = size(f);

%% Construction of Notch Reject Filter.
[X,Y] = meshgrid(0:P-1, 0:Q-1); 
X = X'; %Transpose
Y = Y'; %Transpose

Dk = sqrt((X - floor(P/2) - uk).^2 + (Y - floor(Q/2) - vk).^2); 
D_k = sqrt((X - floor(P/2) + uk).^2 + (Y - floor(Q/2) + vk).^2);

H = (1 ./ (1 + (D0 ./ Dk).^n)) .* (1 ./ (1 + (D0 ./ D_k).^n));

end