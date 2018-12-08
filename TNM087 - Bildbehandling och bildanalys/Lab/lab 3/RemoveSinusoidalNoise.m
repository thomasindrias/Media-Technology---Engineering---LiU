function out=RemoveSinusoidalNoise(in,D0)
%% Lab3, Task 3
%% Removes the most dominant sinusoidal noise
%
% Removes the most dominant sinusoidal noise by applying a Butterworth
% Notch Reject filter in the frequency domain
%
%% Who has done it
%
% Author: Thomas Indrias (thoin216)
% Co-author: NaN
%
%% Syntax of the function
%      Input arguments:
%           in: the original input grayscale image (which is corrupted by
%           sinusoidal noises) of type double scaled between 0 and 1.
%           D0: The bandreject width of the Notch filter being constructed
%
%      Output argument:
%           out: the output image where the most dominant sinusoidal noise
%           is eliminated from the input image
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: today
%
% Gives a history of your submission to Lisam.
% Version and date for this function have to be updated before each
% submission to Lisam (in case you need more than one attempt)
%
%% General rules
%
% 1) Don't change the structure of the template by removing %% lines
%
% 2) Document what you are doing using comments
%
% 3) Before submitting make the code readable by using automatic indentation
%       ctrl-a / ctrl-i
%
% 4) Your code should work for any given input arguments, if they are
%    fulfilling the conditions specified in the syntax of the function
%
% 5) In case a task requires that you have to submit more than one function
%       save every function in a single file and collect all of them in a
%       zip-archive and upload that to Lisam. NO RAR, NO GZ, ONLY ZIP!
%
% 6) Often you must do something else between the given commands in the
%       template
%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%
%% Localize the most dominant sinusoidal noise
% The peaks of sinusoidal noises come in pair. You are supposed to find
% the most dominant pair. Actually, it is enough if you locate one of these two.
% In the Notch filter, however, you will create notches at both of them.
% Read the pdf document related to this task for help.

F = fftshift(fft2(in)); % the Fourier spectrum (i.e. the magnitude of the Fourier transform)
                % of the image followed by fftshift

Flog = fftlog(in); %Better to look at the logarithmic spectrum 
                   %to find real local maximas.

% figure, imshow(Flog); Debug

F2 = Flog; %Copy

%Find DC-Term
dc = max(F2(:));
[r_dc, c_dc] = find(F2 == dc); %center of spectrum (DC-Term)

F2(r_dc-2:r_dc+2 , c_dc-2:c_dc+2) = 0; % make a copy of F and set the pixel values at the center and a
                                       % neighborhood around it to a small number (for example 0)

% the row number of one the two dominant peaks
% the column number of the same peak as above
max_num = max(F2(:));
[r, c] = find(F2 == max_num); %Two pair dominant peaks. 

%% Construct Notch filter
% If you want, you can write a separate function to construct the Notch filter.
% If you do so, don't forget to submit that MATLAB function as well.
%
%% Find uk and vk to construct the Butterworth bandreject filter
% Use the position of one of the peaks to find uk and vk, which indicate the
% position of the found maximum relative the center of the spectrum.
%
% In the lecture notes for Chapter 5, you can find more explanation on what uk
% and vk are
%

uk = r_dc - r(1); % uk and vk are the positions of the peaks relative the center of the spectrum
vk = c_dc - c(1);
    

%% Construct the Butterworth Bandreject Notch filter
% If you want, you can write a separate function to construct the Notch filter.
% If you do so, don't forget to submit that MATLAB function as well.
%
% You have already created Gaussian filter transfer functions in Task2 of this lab.
% It is done similarly. In the lecture notes for Chapter 5, you can find
% good examples on how to create such a filter transfer function

n = 2; % as specified in the task, the order should be 2


H = bnrf(F2, uk, vk, D0, n); % The filter transfer function of the Notch bandreject filter

% figure, imshow(H); Debug

%% Create the output image
% Apply the Notch filter on the input image in the frequency domain, and go
% back to the spatial domain to obtain the output image

figure, imshow(H .* Flog); %Debug: Used to check if the peaks are filtered.

res = H .* F;

% figure, imshow(H .* Flog); Debug

out = real(ifft2(ifftshift(res))); % the final output image, where the most dominant sinusoidal noise is eliminated

figure
imshow(in)
figure
imshow(out)
%% Test your code
% Test your code using at least five different test images as specified in
% the pdf document for this task
%% Answer this question:
% For image Einstein_sinus_1, What is the smallest D0 that removes the noise almost completely?
% Answer: I found that D0 = 12 worked pretty well.