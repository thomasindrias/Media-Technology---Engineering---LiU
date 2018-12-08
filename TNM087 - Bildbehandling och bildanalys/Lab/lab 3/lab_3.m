%% TASK 1.1 Preparation: 2D Fourier spectrum

cTP = im2double(imread('images\characterTestPattern.tif'));
cTP2 = im2double(imread('images\characterTestPattern_2.tif'));
cTP3 = im2double(imread('images\characterTestPattern_3.tif'));
%figure, imshow(cTP);

%1
Spec1 = fftlog(cTP);

%2
cTP_shift = circshift(cTP, [100, -200]);
Spec2 = fftlog(cTP_shift);

%3
%What we've done with circshift is that we have tiles of the same image.
%When shifted for example to the right, the information to the right will
%be gone but the tile to the left becomes visible. you could say that the
%same information that was removed will appear on the opposite side. This
%means that the information is still there but with different position.
%We can see that the shift does not correspond to a frequency shift
%(translation).

%4
cTP_rot = imrotate(cTP, 15, 'bicubic');
Spec3 = fftlog(cTP_rot);

%5
% Yes, we can see that the spectrum for Spec 3 is rotated. It can be said
% that if the image is rotated, the spectrum of the image will be rotated
% with the same angle.

%6
Spec4 = fftlog(cTP2);

%7
%The vertical lines in the image results to more detail in the horizontal
%axis (periodicity) and less in the vertical axis. This can be seen in
%Spec1 and Spec4. The spectrum, spec1 shows that there is more details in
%the horizontal axis. In spec4 (without the vertical lines in the image) we
%can see that there is less detail in the horizontal axis because there is
%no more variance from the vertical lines in the image.

%8
%In this case, there would be less detail in the horizontal axis 
%resulting to a spectrum with less magnitude in the vertical axis.

%9
Spec5= fftlog(cTP3);

%10
%The same principle applies here. Since we removed the diagonal lines.
%There will be less detail in the diagonal axis in the spectrogram.

%% TASK 1.2: Preparation: Period and Frequency
v2 = imread('images\verticalbars_2.tif');
v4 = imread('images\verticalbars_4.tif');
fftlog(v2);
fftlog(v4);

%11
%If we transpose, we rotate the image 90 degrees clockwise meaning that we
%will have a point on the top of the spectrum and in the centrum (for v2).

%12
%Frequency = 0.25 cycles/pixel
%It would appear +- 1/2 from the centrum on the horizontal axis in the
%spectrum.

%13
%Frequency = 0.0033 cycles/pixel
%It would appear +- 1/150 from the centrum on the horizontal axis in the
%spectrum.

%% TASK 1.3: The importance of the spectrum and the phase angle
E1 = im2double(imread('images\Einstein1.jpg'));
E2 = im2double(imread('images\Einstein2.jpg'));

F1 = fftshift(fft2(E1));
F2 = fftshift(fft2(E2));
Spec_E1 = abs(F1);
Spec_E2 = abs(F2);
Ang_E1  = angle(F1);
Ang_E2  = angle(F2);

%14
E1_E2 = real(ifft2(Spec_E1.* exp (1i * Ang_E2)));
figure, imshow(E1_E2);

%15
E2_E1 = real(ifft2(Spec_E2.* exp (1i * Ang_E1)));
figure, imshow(E2_E1);

%16
%It is the phase angle that has the biggest impact on the structure which
%can be seen in the previous tasks. The image corresponding the respective
%phase angle dominates the transformed image.

%% TASK 2: MATLAB code for filtering in the frequency domain 
img1 = im2double(imread('images\Einstein1.jpg'));
img2 = im2double(imread('images\Einstein2.jpg'));
img3 = im2double(imread('images\characterTestPattern.tif'));

figure, imshow(img3); %Original image

[olp, ohp] = FilterFreq(img3, 30);
figure, imshow(olp); %Gaussian low-pass filtered image
figure, imshow(ohp); %Gaussian high-pass filtered image

%% TASK 3: MATLAB code for removing sinusoidal noise
img1 = im2double(imread('images\astronaut-interference.tif'));
img2 = im2double(imread('images\Einstein_odd_sinus.tif'));
img3 = im2double(imread('images\Einstein_sinus_1.tif'));
img4 = im2double(imread('images\Einstein_sinus_2.tif'));
img5 = im2double(imread('images\car-moire-pattern.tif'));

RemoveSinusoidalNoise(img3, 12);