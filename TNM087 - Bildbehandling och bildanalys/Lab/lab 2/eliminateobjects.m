function output=eliminateobjects(im, q)
%% LAB2, TASK 3
%% Eliminates objects smaller than those enclosed by a square of size q x q
%
% Eliminate objects smaller than (or equal to) those enclosed by a square
% of size q x q pixels by filtering the image by appropriate box kernel in
% one pass of the kernel over the image followed by thresholding the
% filtered result by an appropriate threshold value. In the input image,
% the background pixels have an intensity of B=0.1 and all objects have an
% average intensity value of Q=0.8. Suppose that we want to reduce the
% average intensity of those objects to one fourth of the average intensity
% of the objects (or less). That is, we want to reduce the average
% intensity to Q/4 or less.
%
%% Who has done it
%
% Author: Thomas Indrias (thoin216)
% Co-author: NaN
%
%% Syntax of the function
%      Input arguments:
%           im: the original input grayscale image of type double scaled
%               between 0 and 1, containing a number of objects
%           q: The size that is specified in the task (all objects smaller
%              than (or equal to) those enclosed by a square of size q × q
%              pixels have to be eliminated)
%
%      Output argument:
%           output: the result after eliminating all objects smaller
%                   than q x q in the input image
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
%
%% Finding the size of the box filter
Q=0.8; %The average intensity of the objects
B=0.1; %The background pixel intensity
%
% we want to reduce the average intensity of the objects smaller than q x q
% to Q/4. Write the equation to calculate the size of the box filter (n x n) 
% based on q, B and Q.
% The equation here:

n_formula = q * sqrt((4*(Q - B)/(Q - 4*B))) % The size of the required filter
    
%% Find the smallest (odd) size of the filter here:

if(mod(ceil(n_formula),2)) % the smallest odd size of the filter 
    n = ceil(n_formula); % if i.e. 14.56 => 15
else
     n = ceil(n_formula) + 1; %if i.e. 15.56 => 17
end

%% Construct the box kernel here:

fbox = ones(n, n) / (n*n); % the box filter kernel


%% Apply the box filter kernel to the image here:

im_filt = imfilter(im, fbox, 'symmetric'); % the filtered image

%% Threshold the filtered image
% If you have done everything correctly so far, the background and all
% objects smaller than q x q will hold pixel values smaller than Q/4.
% Use an appropriate threshold value (what is an appropriate threshold value?) 
% to threshold the filtered image. Call the resulting image
% after thresholding o_thresh. In this image, the background and all objects
% smaller than q × q are supposed to be black (0) and larger objects and
% around them to be white (1). Notice that you don't need to use for loops
% here. This operation can be done by only a one-line MATLAB command.
% Threshold the filtered result here:


o_thresh = im_filt > Q/4; % The result of thresholding the filtered image

%% Creating mask
% Use the image created in the previous section, i.e. o_thresh, to create
% a mask to identify only objects smaller than q × q. In this mask
% all pixels containing the objects smaller than q × q should be white (1) 
% and the rest black (0). This means that, those pixels that are not
% background pixels (in the original image), and are 0 in o_thresh are the
% objects that are smaller than q x q.
% Notice that you don't need to use for loops here. This operation can be 
% done by only a one-line MATLAB command.
%
% HINT: You can combine a number of logical operations in one line. The 
% operations are performed elementwise in MATLAB. 
% Let us give two examples:
% 
% Example 1:
% OUT= (IN==2);
%
% In the above example, OUT is a logical image containing either 1 or 0.
% At those pixels where the condition to the right is fulfilled, OUT will 
% be 1, and at other pixels, OUT will be 0. In the above example, OUT will
% be 1 at the positions where IN holds 2. At other positions, OUT will be 0.
%
% Example 2:
% OUT= (IN1~=2 & IN2==0);
%
% In the above example, OUT will be 1 at the positions where IN1 
% is NOT 2 AND IN2 is 0.
%
% Create the mask here:

mask = (o_thresh==0); % the mask

%% Create the output image
% Use the mask created above to find the output image. In the result (output),
% objects smaller than q × q are eliminated. This can be done by logical
% operations. At those positions that mask is 1, the output image has to
% have the value of the background (i.e. B=0.1). At other positions, it
% should be equal to the original image.
% Notice that you don't need to use for loops here. This operation can be
% done using only a one-line MATLAB command.
%
% HINT: Let us give an example. Assume that you have created a mask, holding 
% logical values 0 or 1. You want OUT to be equal to the image IN1, 
% where mask is 1, and equal to IN2 where mask is 0. This can be done by
% the following command:
%
% OUT= mask.*IN1 + (~mask.*IN2);
%
% Create the output image here:


output = mask.*B + (~mask.*im); % the output image

%% Test your code
% Test your code on at least four different input images, as specified 
% in the document for Task 3. Don't forget to answer the following
% question regarding the image test4.
%
%
%% Answer this question:
% Why couldn't your code eliminate one of the 2 x 2 objects in test4, when q=2? 
% Your answer here:
% q = 2 results to a 7x7 box filter. If the 2x2 square is close to
% the 6x6, the nxn grid will overlap a part the 6x6 square. The filter will
% then exclude the 2x2 square (below the 6x6). If q >= 6, the grid will
% be 17x17. This will extend 10 columns down the 6x6 square and will overlap
% whole 2x2 causing it to get filterered.
%
%