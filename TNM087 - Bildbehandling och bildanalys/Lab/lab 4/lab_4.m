%% Task 1 Preparation: Hough transform
Image1a = imread('images\Image1a.tif');
Image1b = imread('images\Image1b.tif');

%1
[H1, theta1, ro1] = hough(Image1a, 'Rhoresolution', 5, 'Theta', -90:0.5:89.5);
H_stretch = (H1 - min(H1(:))) / (max(H1(:)) - min(H1(:)));

%figure, imshow(H_stretch);
%figure, imhist(H_stretch);

%2
% 65 degreees (believe it or not). Through MATLAB data plot tool, I chose
% the pixel value for X axis (around 311). The ratio becomes 310/360 which
% I then multiplied with 180 degrees. Since angle is -90 to 90, I substract
% 90 degrees from the result. (310/360) * 180 - 90 = 65
[r, t] = find(H1 == max(H1(:)));
ang1 = theta1(t);
d1 = ro1(r);

%3
%The exact value is 65 degrees.

%4
% A rotation to the horizontal level would need an angle of 90 - 65 = 25
% degrees clockwise.

%5
Image1a_rot = imrotate(Image1a, -25, 'bicubic', 'crop');
%figure, imshow(Image1a_rot);


%6
[H2, theta2, ro2] = hough(Image1b, 'Rhoresolution', 5, 'Theta', -90:0.5:89.5);
[r2, t2] = find(H2 == max(H2(:)));
ang2 = theta2(t2);
d2 = ro2(r2);
% Exact angle is -75 degrees.

%7 
% 90 - 75 = 15 degrees counter clockwise.

%8
Image1b_rot = imrotate(Image1b, 15, 'bicubic', 'crop');
figure, imshow(Image1b_rot);

%% Task 1 Preparation: Morphology
Image1c = imread('images\Image1c.tif');
figure, imshow(Image1c);

%9
SE1 = strel('disk', 3);
IM_oc = imclose(imopen(Image1c, SE1), SE1);
%figure, imshow(IM_oc);

%10
SE2 = strel('line', 6, 0);
Image1c_clean = imopen(IM_oc, SE2);
%figure, imshow(Image1c_clean);

%11a
SE3 = strel('disk', 11);
Image1c_clean_rect = imopen(Image1c_clean, SE3);
%figure, imshow(Image1c_clean_rect);

%11b
SE4 = strel('disk', 15);
Image1c_clean_small_disk = imopen(Image1c_clean_rect, SE4);
%figure, imshow(Image1c_clean_small_disk);

%11c
SE5 = strel('rectangle', [15, 100]);
Image1c_only_rect = imopen(Image1c_clean, SE5);
%figure, imshow(Image1c_only_rect);

%11d
[r, c] = size(Image1c);
RGB = zeros(r, c, 3);
RGB(:,:,1) = Image1c_only_rect;
RGB(:,:,2) = Image1c_clean_small_disk;
RGB(:,:,3) = Image1c_clean_rect - Image1c_clean_small_disk;
figure, imshow(RGB);
%% Task 1 Preparation: Labelling and object features

%12
L = bwlabel(Image1c_clean);
%figure, imshow(L, []);

%13
S = regionprops(L, 'Perimeter', 'Area', 'EulerNumber');
for n=1:length(S)
   Perimeter(n) = S(n).Perimeter;
   Area(n) = S(n).Area;
   Euler(n) = S(n).EulerNumber;
end

Large0 = find(Area > 3000);

Large0_Im = zeros(r, c);

for n=1:length(Large0)
   Large0_Im(L == Large0(n)) = 1; 
end

%figure, imshow(Large0_Im);
%Perimeter(Large0) gives: 327.4740  325.6300  324.3400  324.9850

%14
%figure, hist(Perimeter);
% Threshold: 150
% Labels: 1, 8 and 10.
Small0 = find(Perimeter < 150);

%15
% Threshold: 250
% EulerNumber: 1
% Labels: 4 and 7.
Large_pizza = find(Perimeter > 250 & Euler == 1); %largest perimeter and no holes

Large1_Im = zeros(r, c);

for n=1:length(Large_pizza)
   Large1_Im(L == Large_pizza(n)) = 1; 
end

figure, imshow(Large1_Im);
%% TASK 2: MATLAB code for counting the number of brick rows in a brick wall image 
brick1 = imread('images\brick1.jpg');
brick2 = imread('images\brick2.jpg');
brick3 = imread('images\brick3.jpg');

[IMG1, nofb1] = CountBrickRows(brick1); % There are actually 13 rows in the image.
%figure, imshow(IMG1);

[IMG2, nofb2] = CountBrickRows(brick2);
%figure, imshow(IMG2);

[IMG3, nofb3] = CountBrickRows(brick3);
%figure, imshow(IMG3);

%% TASK 3: Segmentation, object features and classification 
macnrice1 = imread('images\MacnRice1.tif');
macnrice2 = imread('images\MacnRice2.tif');
macnrice3 = imread('images\MacnRice3.tif');

%figure, imshow(CountObjects(macnrice1));
%figure, imshow(CountObjects(macnrice2));
%figure, imshow(CountObjects(macnrice3));