function model = construct_model_of_invariant(invariant_trials_motion,indices_training_trials,width_band,use_weights)
% Calculating a model of a motion by combining the information in several
% trials of this motion. For each trial, the mean DTW-distance to the
% other trials gives a weight in the calculation of the model. The model is
% built by comparing the model with a new trial and adjusting it by looking
% to the DTW-distance and -path between trial and model.
%Input: invariant_trials_motion =  matrix with trials
%Input: indices_training_trials = indicates which trials are used to construct the model
%Output: model of the motion

M = size(invariant_trials_motion,2);

% Calculate DTW-distance between all combinations of 2 trials
DM_invariants=zeros(M);
for k=1:M
    for j=k:M
        DM_invariants(j,k) = DTW_algorithm(invariant_trials_motion(:,k),invariant_trials_motion(:,j),width_band);
    end
end
DM_invariants = DM_invariants' + DM_invariants; % copy lower diagonal to upper diagonal to make a symmetric matrix

% Give each trial a weight, higher weight means better correspondence to other trials
% first column indices of trials, second column weights
if use_weights
    weights = weight_trials(DM_invariants);
else
    % uniform weighting
    weights = ones(size(invariant_trials_motion,2),2);
    weights(:,1) = 1:size(invariant_trials_motion,2);
    weights(:,2) = weights(:,2)/size(invariant_trials_motion,2);
end
  
    % initialize model with first trial of training data
    model=invariant_trials_motion(:,indices_training_trials(1));
    
    % reorder weights again
    % @Maxim TODO rework
    [~,t] = sort(weights(:,1),'ascend');
    weights = weights(t,:);
    
    weight_model=weights(indices_training_trials(1),2);
    
    for j=2:length(indices_training_trials) %number of trials in model
        index_new_trial = indices_training_trials(j); %index of new trial
        new_trial = invariant_trials_motion(:,index_new_trial); %retrieve the trial
        
        %calculate the warping path between the trial and current model
        [~,p,q] = DTW_algorithm(model,new_trial,width_band,1);
        
        %calculate new model as the weighted average between the old model and the new trial
        new_model=weighted_average_trials(model,new_trial,weight_model,weights(index_new_trial,2),p,q);
        
        weight_model=weight_model+weights(index_new_trial,2); %adjust weight of the model
        %plot([model new_trial new_model(:,2)]) %blue: old model, red: new model
        model=new_model';
    end
end