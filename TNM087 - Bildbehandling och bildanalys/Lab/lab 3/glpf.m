function H = glpf(f, D0)
%Generates a Gaussian low-pass filter with the same size as the input image
%INPUT:
%f = input image for size control.
%cf = cutoff 
%OUTPUT:
%lp = gaussian low pass filter

%% Size
[P, Q] = size(f);

%% Construction of Gaussian Low Pass Filter
[X,Y] = meshgrid(0:P-1, 0:Q-1); 
X = X'; %Transpose
Y = Y'; %Transpose

D = sqrt((X - floor(P/2)).^2 + (Y - floor(Q/2)).^2); %Distance from the center.

H = exp(-D.^2 / (2 * D0^2));

end