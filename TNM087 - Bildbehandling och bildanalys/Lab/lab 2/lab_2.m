%% Prep: 1 Testing different box filters

img = im2double(imread('images/TestPattern.tif')); %img load

%1
boxk1 = ones(9,9)/(9*9);
Image1 = imfilter(img, boxk);
imshow(Image1);

%2
boxk2 = ones(21,21)/(21*21);
Image2 = imfilter(img, boxk2);
figure, imshow(Image2);

%3
% This means that 21x21 has a lower cutoff frequency because it 
% because it is filtering out more of the higher frequencies.

%4
% Zero padding introduces dark borders in the filtered image.

%5
boxk3 = ones(21,21)/(21*21);
Image3 = imfilter(img, boxk3, 'symmetric');
figure, imshow(Image3);

%6
laplacek = zeros(21,21)/(21*21);
laplacek(floor(21/2)+1,floor(21/2)+1) = 1;
boxk4 = ones(21,21)/(21*21);
hp1 = laplacek - boxk4;
Image4 = imfilter(img, hp1, 'symmetric');
figure, imshow(Image4);

%7
% It is being clipped at 0 by the display causing it to contain negative 
% values. This results to the black areas. This can be seen in the average % value => -1.5736e-15.

%8
Image5 = img + Image4;
figure, imshow(Image5);

%% Prep: 2 Testing Sobel filters and gradient
sobx = [-1 -2 -1;
         0  0  0;
         1  2  1];

soby = [-1 0 1;
        -2 0 2;
        -1 0 1];
    
img = im2double(imread('images/TestPattern.tif')); %img load

%1
Image6 = imfilter(img, sobx, 'replicate');
figure, imshow(Image6);

%2
Image7 = imfilter(img, soby, 'replicate');
figure, imshow(Image7);

%3
Image8 = sqrt(Image6.^2 + Image7.^2);
figure, imshow(Image8);
%% Task 2 MATLAB code for spatial filtering
img = im2double(imread('images/zoneplate.tif')); %img load

boxk1 = ones(9,9)/(9*9);
boxk2 = ones(21,21)/(21*21);

[olp, ohp, obr, obp, oum, ohb] = myfilter(img, boxk1, boxk2);

figure, imshow(img); % original
%figure, imshow(olp); % low pass
%figure, imshow(ohp); % high pass
%figure, imshow(obr); % band reject
%figure, imshow(obp); % band pass
%figure, imshow(oum); % unsharp mask
%figure, imshow(ohb); % highboost 

%% Task 3 MATLAB code for eliminating objects smaller than a given size
img1 = im2double(imread('images/test1.tif')); %img load
img2 = im2double(imread('images/test2.tif')); %img load
img3 = im2double(imread('images/test3.tif')); %img load
img4 = im2double(imread('images/test4.tif')); %img load

figure, imshow(eliminateobjects(img4, 2))