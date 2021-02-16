function weights=weight_trials(DTW)
% Each trial receives a weight for the calculation of the model. The better
% this trial fits to the other trials (sum of DTWs low), the higher the weight.
%Input: DTW-matrix containing distance of every trial to another trial
%Output: Weights - First column: index of trial, Second column: weights sorted from high to low

N=length(DTW);
x=sum(DTW,2)/(N-1); %reason for (N-1): we exclude the distance from a trial to itself (=0) from our estimate of the mean distance to other trials
mean_DTW= mean(x);

% An exponential distribution provides a measure of the mean distance of a trial to the other trials
lambda=1/mean_DTW;
probability = lambda*exp(-x*lambda);

% Sort weights from high to low
[sorted_values,indices] = sort(probability,'descend');
weights = [indices sorted_values];
