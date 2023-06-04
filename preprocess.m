% Define a function with input parameters img and number
function preprocess(img,number) 

figure, imshow(img);
% Get the size of the input image and store it in variables M and N
[M,N] = size(img); 

% Define a standard deviation based on the size of the image
sig = 0.0015*M; 

% Calculate the filter size based on the standard deviation
r = ceil(6*sig); 

% Create a Gaussian filter with the calculated size and standard deviation
w1 = fspecial('gaussian',r, sig); 

% Apply the Gaussian filter to the input image
img = imfilter(img, w1,'replicate'); 

figure, imshow(img);
% part a
% Get the red channel of the filtered image
red = img(:,:,1); 
figure, imshow(red);
img_width = size(img, 2);

% Calculate the center of the input image
img_center = img_width / 2; 

% Set the center of the region of interest
region_center = img_center + 20; 

% Calculate the left boundary of the region of interest
x_min = floor(region_center) - 20; 

% Calculate the right boundary of the region of interest
x_max = floor(region_center) + 20; 

% Extract the region of interest from the original image matrix
cropped_img = img(:, x_min:x_max, :);

%figure, imshow(red); % Display the green channel of the filtered image

% Calculate the threshold value for binarizing the green channel
threshold = graythresh(red); 

% Display the threshold value in the command window
fprintf('Threshold value is %d',threshold)
%disp(threshold); 

% Convert the green channel to binary using the threshold
binary_img = imbinarize(red, threshold);

% Display the binary image
figure, imshow(binary_img); 

% part d
% Create a disk-shaped structuring element for morphological operations
se = strel('disk', 3); 

% Erode the binary image using the structuring element
eroded_img = imerode(binary_img, se); 

% Remove small connected components from the binary image
eroded_img = bwareaopen(eroded_img, 50); 

% Display the eroded and cleaned binary image
figure, imshow(eroded_img); 

% Fill any remaining holes in the image
filled_img = imfill(eroded_img, 'holes'); 
filled_img = ~filled_img;

% Display the filled binary image
figure, imshow(filled_img);

% part c
% Find the white areas in the filled image
white_areas = filled_img == 1;

% Replace the white areas with the corresponding areas in the original image
result_img = img;
result_img(repmat(white_areas, [1,1,3])) = img(repmat(white_areas, [1,1,3]));

% Make the other areas black
result_img(repmat(~filled_img, [1,1,3])) = 0;

% part e
% Crop the image boundaries
result_img = imcrop(result_img, [10, 10, size(result_img,2)-20, size(result_img,1)-20]);

% Display the result
figure, imshow(result_img);

% part b
% Detect edges in the binary image using the Canny edge detector
canny_img = edge(filled_img, 'canny'); 

% Display the edges
figure, imshow(canny_img); 

% Define the directory for saving the processed images
save_img_dir='D:\RIT courses\CompVision\project\processed_images1'; 

% Define the filename for the processed image
new_name = strcat(num2str(number),'.png'); 

% Save the processed image with the defined filename and directory
imwrite(result_img, fullfile(save_img_dir,new_name)); 

end 
