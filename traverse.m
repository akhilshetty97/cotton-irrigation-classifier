function traverse()

dirpath = 'D:\RIT courses\CompVision\project\cotton images';

files = dir(fullfile(dirpath, '*.TIF'));

for i = 1 : 1
    imgpath = fullfile(dirpath, files(i).name);
    %disp(imgpath);
    I = imread(imgpath);
    match = regexp(imgpath, 'mosaic(\d+)\.TIF', 'tokens');
    number = str2double(match{1}{1});
    
    %figure,imshow(I);
    % Read the TIF image
    I = I(:,:,1:3);
    % Convert to PNG format and write to file
    imwrite(I, 'image.png', 'png');
    img=imread("image.png");
    preprocess(img,number);
end
CNN()
end