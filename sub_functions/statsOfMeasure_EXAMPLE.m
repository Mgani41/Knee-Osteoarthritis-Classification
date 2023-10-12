clearvars
clc

%% Load a random Matlab example: iris dataset
load fisheriris

% Randomize the measurements and groups in the data.
rng(0,'twister'); % For reproducibility
numObs = length(species);
p = randperm(numObs);
meas = meas(p,:);
species = species(p);

% Train a discriminant analysis classifier by using measurements in the first half of the data.
half = floor(numObs/16); % I decreased the number of training samples to have more wrong classified examples
% half = floor(numObs/2);
training = meas(1:half,:);
trainingSpecies = species(1:half);
Mdl = fitcdiscr(training,trainingSpecies);

% Predict labels for the measurements in the second half of the data by using the trained classifier.
sample = meas(half+1:end,:);
grouphat = predict(Mdl,sample);

% Specify the group order and display the confusion matrix for the resulting classification.
group = species(half+1:end);
[C,order] = confusionmat(group,grouphat,'Order',{'setosa','versicolor','virginica'});

% I added this line to verify if it works for 2 classes only
% C = C(2:3, 2:3);

% Plot the confusion matrix C
figure
confusionchart(C)

%% Use the function you've just downloaded
stats = statsOfMeasure(C, 1);

% To access the "false_positive" of the 2nd class
stats.classes(2,2)