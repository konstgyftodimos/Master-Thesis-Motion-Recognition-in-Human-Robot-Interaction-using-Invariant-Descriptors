function index = classify_trial(invariants_trial_motion,models,choiceInvariants,width_band,use_discrimination)
% Classify the given trial to a certain model of a motion
% input: invariants_trial_motion = the trial to be classified
% input: models = the models to which the trial is compared
% input: choiceInvariants = contains which of the six invariants are used for classification
% input: width_band = width of the band used in the DTW algorithm
% output: index = contains the number of the model which corresponds most to the given trial

nb_models = length(models);

% Turn NaN-elements in trial into '0' @Maxim TODO check how much this happens
invariants_trial_motion(isnan(invariants_trial_motion) == 1) = 0;

invariant_names = fieldnames(choiceInvariants);
probabilities = NaN(length(invariant_names),nb_models);
for i=1:length(invariant_names)
    invariant_name = invariant_names{i};
    if (choiceInvariants.(invariant_name)==1)
        for j=1:nb_models
            model = models(j).models.(invariant_name);
            DTW_distance = DTW_algorithm(invariants_trial_motion(:,i),model.model,width_band);
            if use_discrimination
                discrimination = model.discrimination;
                lambda=1/discrimination;
                probabilities(i,j) = lambda*exp(-DTW_distance*lambda);
            else
                probabilities(i,j) = 1/DTW_distance;
            end
        end
    end
end

% Remove the NaN values (unused models)
probabilities = reshape(probabilities(~isnan(probabilities)),[],nb_models);

% Normalize
norm_probabilities = probabilities./repmat(sum(probabilities,2),1,nb_models);

% Combine probabilities of o1 o2 , ... (joint probabilities)
probabilities_combination = prod(norm_probabilities,1);

% Classified model has the highest probability
[~,index]=max(probabilities_combination);

%%Debugging
% n=1;
% plotNames = {'O1','O2','O3','V1','V2','V3'};
% plottitle = 'Dimless Invariants';
% plotFunctionCompare(invariants_trial_motion,[models(n).models.O1.model models(n).models.O2.model models(n).models.O3.model models(n).models.V1.model models(n).models.V2.model models(n).models.V3.model],plotNames,plottitle);
%
% n=2;
% plotFunctionCompare(invariants_trial_motion,[models(n).models.O1.model models(n).models.O2.model models(n).models.O3.model models(n).models.V1.model models(n).models.V2.model models(n).models.V3.model],plotNames,plottitle);
%
% index
% norm_probabilities
