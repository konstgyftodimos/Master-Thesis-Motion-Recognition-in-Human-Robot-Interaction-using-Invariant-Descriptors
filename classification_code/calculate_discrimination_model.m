function [discrimination, sigma] = calculate_discrimination_model(model, invariant_trials_motion, width_band)
% The discrimination of a model is a measure for how good the trials
% fit to the created model (the lower the discrimination, the better the
% model, the lower the DTW-distance of a trial would have to be, to be
% assigned to this model)
% input: model = model of one of the six invariants for a specific motion
% input: invariant_trials_motion = matrix with one of the six invariants for all the trials of a motion
% input: width_band = width of the band used in the DTW algorithm
% output: discrimination = mean distance of model to trials
% output: sigma = standard deviation of distance from model to trials

M=size(invariant_trials_motion,2);
DTW=zeros(M,1);

% Compute distance between each trial and the model
for j=1:M
    DTW(j)= DTW_algorithm(invariant_trials_motion(:,j),model,width_band);
end

% Compute the mean distance and the standard deviation
discrimination=mean(DTW);
sigma = std(DTW);
