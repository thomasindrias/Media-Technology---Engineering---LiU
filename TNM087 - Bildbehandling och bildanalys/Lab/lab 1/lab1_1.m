%%
image = imread('Lab1_Images\book-cover.tif');

%1A
maximg = max(image(:));

image2 = image/16;

%1B
maximg2 = max(image2(:));

%1D
image3 = image2 * 16;

%1C 
maximg3 = max(image3(:));

%%
clear

image = im2double(imread('Lab1_Images\einstein-low-contrast.tif'));
imshow(image);

%2A
maximg = max(image(:));
minimg = min(image(:));

%2B
%imhist(image);

%2C
K = 1;
image_stretch = K * (image - minimg) / (maximg - minimg);
figure, imshow(image_stretch);
figure, imhist(image_stretch);

%2D
maximg_new = max(image_stretch(:));
minimg_new = min(image_stretch(:));
%%
clear

image_mask = im2double(imread('Lab1_Images\angiography-mask-image.tif'));
image_live = im2double(imread('Lab1_Images\angiography-live-image.tif'));

image_diff = image_live - image_mask;

maximg = max(image_diff(:));
minimg = min(image_diff(:));

figure, imshow(image_diff);

%3A
K = 1;
image_stretch = K * (image_diff - minimg) / (maximg - minimg);


figure, imshow(image_stretch);
figure, imhist(image_stretch);

%%
clear

image = im2double(imread('Lab1_Images\pollen-lowcontrast.tif'));

imshow(image);

image_eq = histeq(image);

%4A
figure, imshow(image_eq);

%4B
figure, imhist(image_eq);

%%
clear

image_patt = im2double(imread('Lab1_Images\Shade_pattern.tif'));
image_est = im2double(imread('Lab1_Images\Shade_estimate.tif'));

%5A
%imhist(image_patt);

%5C
image_product = image_patt ./ image_est;
%figure, imshow(image_product);

%5D 
figure, imhist(image_product);

%5E

T = 0.5;
image_seg = image_product < T;
figure, imhist(image_seg);
figure, imshow(image_seg);

%%
clear

I = zeros(400, 600, 3);

I(:, :, 1) = 0;
I(:, :, 2) = 106/256;
I(:, :, 3) = 167/256;

I(150:250, :, 1) = 254/256;
I(150:250, :, 2) = 204/256;
I(150:250, :, 3) = 0;

I(:, 200:300, 1) = 254/256;
I(:, 200:300, 2) = 204/256;
I(:, 200:300, 3) = 0;

%6
imshow(I);


