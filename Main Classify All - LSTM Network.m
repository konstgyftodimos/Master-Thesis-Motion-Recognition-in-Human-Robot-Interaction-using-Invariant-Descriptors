% LOAD AND TRANSFORM THE DATA
% Dataset 1

% addpath('..\motion_classification\KNN_Classification_Datasets')
% load('dimles_FS_200.mat');
% load('Labels.mat');

% Removal of invariants
% X_train(:,[5],:)=[]; 
% X_train(:,[3],:)=[];
% X_test(:,[5],:)=[];
% X_test(:,[3],:)=[];

%% Add Paths

addpath('..\motion_classification\LSTM_Classification_Datasets')
addpath('..\motion_classification\LSTM_Classification_Datasets\net')

load('geom_isa.mat');
load('geom_isa_net_dataset_3.mat');
 %load('geom_isa_net_dataset_2.mat');

    X_train(:,[2],:)=[];
    X_test(:,[2],:)=[];

%% Consider dataset2/dataset3  

%dataset2, 63.79% accuracy
% X_train(144:291,:,:)=[];
% Y_train(144:291,:)=[];
% 
% X_test(393:793,:,:)=[];
% actual_labels(393:793,:)=[];

%dataset3, 75.31% accuracy
X_train(1:143,:,:)=[];
Y_train(1:143,:)=[];

X_test(1:392,:,:)=[];
actual_labels(1:392,:)=[];

%% Normalization Options

% X_train=normalize(X_train);
% X_test=normalize(X_test); 
% 
X_train=normalize(X_train,'center',1);
X_test=normalize(X_test,'center',1); 

% X_train=normalize(X_train,'norm',2); % FAILED BUT INTERESTING RESULTS
% X_test=normalize(X_test,'norm',2);

% Reformulation of Datasets

X_train_reshaped=num2cell(X_train,[2 3]);
XTrain=cellfun(@(x) reshape(x,[],200),X_train_reshaped,'un',0);
X_test_reshaped=num2cell(X_test,[2 3]);
XTest=cellfun(@(x) reshape(x,[],200),X_test_reshaped,'un',0);
YTest=categorical(actual_labels);
YTrain=categorical(Y_train);

%% PLOT 

figure
plot(XTrain{1}')
xlabel("Time Step")
title("Training Observation 1")
numFeatures = size(XTrain{1},1);
legend("Feature " + string(1:numFeatures),'Location','northeastoutside')

%% HYPERPARAMETERS 

miniBatchSize = 49; %14 for dataset2or 49 for dataset3
numHiddenUnits = 100;
maxEpochs = 65;

inputSize = 5; %6 in the normal invariants
numClasses = 5;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','never', ...
    'Verbose',0, ...
    'Plots','training-progress');

%% TRAIN LSTM NETWORK
% net = trainNetwork(XTrain,YTrain,layers,options);

%% TEST LSTM NETWORK

YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');

acc = sum(YPred == YTest)./numel(YTest)

C=confusionmat(YTest,YPred);

for i=1:size(C,1)
C(i,:) = C(i,:)./sum(C(i,:));
end

disp('Confustion Matrix:');
disp(C);

% Best result overall:

%dimless FS
%59.51%
%inputSize = 4; 
%miniBatchSize = 10;
%numHiddenUnits = 100;
%maxEpochs = 300;



%% ANOTHER TEST for dimless FS

addpath('..\motion_classification\LSTM_Classification_Datasets')
load('DIMFSNEWDATA');

% for i=1:size(XTrain)
% XTrain{i}=scaledata(XTrain{i},-2,2);
% end
% 
% for i=1:size(XTest)
% XTest{i}=scaledata(XTest{i},-2,2); 
% end

%plot
figure
plot(XTrain{1}')
xlabel("Time Step")
title("Training Observation 1")
numFeatures = size(XTrain{1},1);
legend("Feature " + string(1:numFeatures),'Location','northeastoutside')

%sort data by equal length - minibatch size

numObservations = numel(XTrain);
for i=1:numObservations
    sequence = XTrain{i};
    sequenceLengths(i) = size(sequence,2);
end

[sequenceLengths,idx] = sort(sequenceLengths);
XTrain = XTrain(idx);
YTrain = YTrain(idx);

figure
bar(sequenceLengths)
ylim([0 30])
xlabel("Sequence")
ylabel("Length")
title("Sorted Data")

miniBatchSize = 9;


%Network Parameters
inputSize = 6;
numHiddenUnits = 16; %6,2,16
numClasses = 10;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

maxEpochs = 300; %use 300 to compare with previous dimFS
miniBatchSize = 9;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','shortest', ...
    'Shuffle','never', ...
    'Verbose',0, ...
    'Plots','training-progress');
%% Train
net = trainNetwork(XTrain,YTrain,layers,options);


%% Test
addpath('..\motion_classification\LSTM_Classification_Datasets')
load('DIMFSNEWDATA');
load('network_06_12_20_dim_fs_2.mat');

numObservationsTest = numel(XTest);
for i=1:numObservationsTest
    sequence = XTest{i};
    sequenceLengthsTest(i) = size(sequence,2);
end
[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);

miniBatchSize = 9;


YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','shortest');

acc = sum(YPred == YTest)./numel(YTest)

C=confusionmat(YTest,YPred);

for i=1:size(C,1)
C(i,:) = C(i,:)./sum(C(i,:));
end

disp('Confustion Matrix:');
disp(C);

%Current Settings 42.55%, network_06_12_20_dim_fs, when using shorting
%sequence to longest!


%Current Settings 50.71%, network_06_12_20_dim_fs_2, when using shorting
%sequence to shortest!














