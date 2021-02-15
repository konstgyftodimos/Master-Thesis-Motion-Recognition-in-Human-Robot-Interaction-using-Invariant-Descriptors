%% Author: Konstantinos Gyftodimos

%% 1. KNN actual calculation - Weight invariants to normalize unit difference + Compare Trajectories not points 

clear;clc;close all;

addpath('..\motion_classification\KNN_Classification_Datasets')
addpath('..\motion_classification\classification_code')

%Choose over descriptor types calculated with analytical formulas:
%load('dimles_FS_200.mat'); %81.18 vs 82.12%(DTW)
%load('dimles_ISA_200.mat'); %74.67 vs 72.12%(DTW) <<<<<<<<

% load('geom_FS_200.mat'); %57.7 vs 50.14% (DTW) <<<<<<<<
%load('geom_ISA_200.mat'); %64.6 vs 70.01%(DTW)

%load('timebased_FS_200.mat'); %53.10 vs 48.73%(DTW) <<<<<<<<
load('timebased_ISA_200.mat'); %50.15 vs 56.395%(DTW)

bool_descriptortype_FS=1;
bool_descriptortype_ISA=0;


%% Initialization

%Normalization weights w.r.t max abs value of each invariant
w1=1/max(max(abs(X_test(:,1,:))));
w2=1/max(max(abs(X_test(:,2,:))));
w3=1/max(max(abs(X_test(:,3,:))));  
w4=1/max(max(abs(X_test(:,4,:))));
w5=1/max(max(abs(X_test(:,5,:))));
w6=1/max(max(abs(X_test(:,6,:)))); 
w=[w1;w2;w3;w4;w5;w6];

%Multiplication of test and train data with corresponding weights
for weight_index=1:size(w,1)
    X_train(:,weight_index,:)=w(weight_index)*X_train(:,weight_index,:);
    X_test(:,weight_index,:)=w(weight_index)*X_test(:,weight_index,:);
end


% if bool_descriptortype_FS 
%     X_train(:,[3],:)=[]; 
%     X_train(:,[5],:)=[];
%     X_test(:,[3],:)=[];
%     X_test(:,[5],:)=[];
%     k=4;
% elseif bool_descriptortype_ISA
%     X_train(:,[6],:)=[];
%     X_test(:,[6],:)=[];
%     X_train(:,[4],:)=[];
%     X_test(:,[4],:)=[];
%     X_train(:,[3],:)=[];
%     X_test(:,[3],:)=[];
%     k=3;
% end
%% Removal of invariants

%Use this for dimensionless FS invariants and change neighbors to k=4
%Result = 81.18%

% X_train(:,[3],:)=[]; 
% X_train(:,[5],:)=[];
% X_test(:,[3],:)=[];
% X_test(:,[5],:)=[];


%Use this for dimensionless ISA invariants and change neighbors k=3
%Result =74.64%

% X_train(:,[6],:)=[];
% X_test(:,[6],:)=[];
% X_train(:,[4],:)=[];
% X_test(:,[4],:)=[];
% X_train(:,[3],:)=[];
% X_test(:,[3],:)=[];

%Use this for geometric FS invariants and change neighbors to k=5
%Result =57.7%

% X_train(:,[3],:)=[];
% X_test(:,[3],:)=[];  

%Use this for geometric ISA invariants and change neighbors to k=1
%Result = 64.60%

% X_train(:,[6],:)=[];
% X_test(:,[6],:)=[];
% X_train(:,[4],:)=[];
% X_test(:,[4],:)=[];
% X_train(:,[3],:)=[];
% X_test(:,[3],:)=[];

%Use this for timebased FS invariants and change neighbors to k=2
%Result = %53.10
% X_train(:,[3],:)=[];
% X_test(:,[3],:)=[];
% X_train(:,[2],:)=[];
% X_test(:,[2],:)=[];

%Use this for timebased FS invariants and change neighbors to k=5
%Result = %50.15
X_train(:,[6],:)=[];
X_test(:,[6],:)=[];
X_train(:,[4],:)=[];
X_test(:,[4],:)=[];
X_train(:,[3],:)=[];
X_test(:,[3],:)=[];

%% Actual Calculation

ed = zeros(size(X_test,1),size(X_train,1),size(X_train,2)); 

%For DTW metric, uncomment next line to turn all NaN values of X_test to 0
X_test(isnan(X_test))=0; 

%Widthband for DTW function
widthband = round(0.15*size(X_test,3));

parfor test_point=1:size(X_test,1)
    disp(['Calculating distances for trial ' num2str(test_point) '/' num2str(size(X_test,1))]);
    ed_single_test = zeros(size(X_train,1),size(X_train,2)); % this is the [100x6] distance matrix for one test point vs all training points for each invariant
    for train_point=1:size(X_train,1)    
        ed_singletest_singletrain = zeros(1,size(X_train,2)); % this is the [1x6] distance matrix for one test point vs one training point for each invariant 
        for invariant=1:size(X_train,2)
                        
            % Compare two [150x1] time series of invariants!
            time_series1 = squeeze(X_test(test_point,invariant,:)); % test data, compress [1 x 1 x 150] into [150x1]
            time_series2 = squeeze(X_train(train_point,invariant,:));  % train data, compress [1 x 1 x 150] into [150x1]
            ed_singletest_singletrain(invariant)=dtw(time_series1,time_series2,'euclidean'); 
        end
        ed_single_test(train_point,:) = ed_singletest_singletrain;
    end
    ed(test_point,:,:) = ed_single_test;
end

ed_new = sum(ed,3); % sum of distances over 3rd dimension 
[ed_final,ind] = sort(ed_new,2); %put all elements in ed in increasing order in each row

%% Find the nearest k for each data point of the testing data

k=5; 
k_nn=ind(:,1:k);
t_labels = zeros(size(k_nn));

%transform k_nn to t_labels, where instead of the number of column as each
%value, the class that corresponds to this column is inserted.

for i=1:size(k_nn,1)
    for j=1:size(k_nn,2)
        if k_nn(i,j)>=1 && k_nn(i,j)<=10
            t_labels(i,j)=1;
        elseif k_nn(i,j)>=11 && k_nn(i,j)<=20
            t_labels(i,j)=2;
        elseif k_nn(i,j)>=21 && k_nn(i,j)<=30
            t_labels(i,j)=3;
        elseif k_nn(i,j)>=31 && k_nn(i,j)<=40
            t_labels(i,j)=4;
        elseif k_nn(i,j)>=41 && k_nn(i,j)<=50
            t_labels(i,j)=5;
        elseif k_nn(i,j)>=51 && k_nn(i,j)<=60
            t_labels(i,j)=6;
        elseif k_nn(i,j)>=61 && k_nn(i,j)<=70
            t_labels(i,j)=7;
        elseif k_nn(i,j)>=71 && k_nn(i,j)<=80
            t_labels(i,j)=8;
        elseif k_nn(i,j)>=81 && k_nn(i,j)<=90
            t_labels(i,j)=9;
        elseif k_nn(i,j)>=91 && k_nn(i,j)<=100
            t_labels(i,j)=10;

        end
    end
end

% Pick the class that appears the most inside t_labels, depending on k

t_labels_final=mode(t_labels,2); 

%it chooses the lowest value when same class appears, do it without mode.

%calculate the classification accuracy
actual_labels=zeros(size(X_test,1),1);

actual_labels(1:109,1)=1;
actual_labels(110:207,1)=2;
actual_labels(208:296,1)=3;
actual_labels(297:399,1)=4;
actual_labels(400:486,1)=5;
actual_labels(487:596,1)=6;
actual_labels(597:690,1)=7;
actual_labels(691:783,1)=8;
actual_labels(784:883,1)=9;
actual_labels(884:983,1)=10;

%Accuracy
accuracy=length(find(actual_labels==t_labels_final))/size(X_test,1);
disp('Overall Classification Accuracy:')
disp(accuracy);

%Confusion Matrix
C=confusionmat(actual_labels,t_labels_final);

for i=1:size(C,1)
C(i,:) = C(i,:)./sum(C(i,:));
end

disp('Confustion Matrix:');
disp(C);




