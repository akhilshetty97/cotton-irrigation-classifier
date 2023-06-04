function CNN()
% Set the input folder and categories
inputFolder = fullfile('processed_images');
categories = {'Rainfed', 'Time_delay', 'Percent_deficit', 'Fully_Irrigated'};

% Create an imageDatastore for the images in each category
imds = imageDatastore(fullfile(inputFolder, categories), 'LabelSource', 'foldernames');

% Count the number of images in each category
tbl = countEachLabel(imds);

% Get the minimum number of images in each category
minSetCount = min(tbl{:,2});

% Split each category into a training and testing set with the minimum number of images
imds = splitEachLabel(imds, minSetCount, 'randomized');

% Get the number of images in each category after splitting
countEachLabel(imds);

% Load the pre-trained ResNet-50 neural network
net = resnet50();

% Print the first and last layers of the network
net.Layers(1)
net.Layers(end)

% Split the image datastore into training and testing sets, and get the image size
[trainingSet, testingSet] = splitEachLabel(imds, 0.7, 'randomized');
imageSize = net.Layers(1).InputSize;

% Augment the training and testing sets and convert them to grayscale
augmentedTrainingSet = augmentedImageDatastore(imageSize, trainingSet, 'ColorPreprocessing', 'gray2rgb');
augmentedTestingSet = augmentedImageDatastore(imageSize, testingSet, 'ColorPreprocessing', 'gray2rgb');

% Set the feature layer to use for training
featureLayer = 'fc1000';

% Get the features from the training set using the ResNet-50 network
trainingFeatures = activations(net, augmentedTrainingSet, featureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

% Get the labels for the training set
trainingLabels = trainingSet.Labels;

% part g
% Train a multi-class SVM classifier on the training features
classifier = fitcecoc(trainingFeatures, trainingLabels, 'Learner', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');


% Get the features from the testing set using the ResNet-50 network
testingFeatures = activations(net, augmentedTestingSet, featureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

% Predict the labels for the testing set using the SVM classifier
predictLabels = predict(classifier, testingFeatures, 'ObservationsIn', 'columns');

% Get the true labels for the testing set
testLabels = testingSet.Labels;

% Compute the confusion matrix and normalize it
confMat = confusionmat(testLabels, predictLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat, 2));

% Display the confusion matrix
disp(confMat);

% part h
% Compute the test accuracy
accuracy = mean(diag(confMat));
fprintf('Test Accuracy: %0.2f%%\n', 100*accuracy);
end
