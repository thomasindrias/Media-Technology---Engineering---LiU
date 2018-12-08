%% Part 1.2
Image1 = imread('Lab1_Images\IntensityRamp.tif');

figure, imshow(Image1);
GImage = GammaCorrection(Image1, 2.5, 0.01, 0.98);
figure, imshow(GImage);

%% Part 1.3
RGBflower = imread('Lab1_Images\RGBflower.tif');
IRflower = imread('Lab1_Images\IRflower.tif');
[RGB_Range, IR_Select] = LevelSlicing(RGBflower, IRflower, 0.1);