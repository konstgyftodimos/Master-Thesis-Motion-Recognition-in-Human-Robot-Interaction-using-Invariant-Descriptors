function MODEL = construct_model_motion(directory,motionDir,executionDirs,trainingdata_indices,typeInvariant,params)
% Assembling all models of the invariants of a motion into a struct. Information on the
% models (discrimination and sigma) is also kept
% Input: invariants_trials_motion = matrix containing all the relevant trials of a motion
% Input: trainingdata_indices = indicates which trials are used to construct the model
% Output: MODEL = constructed models of each invariant

%Initialization
executionType = params.executionType;
nb_samples = params.nb_samples;
invariants_trials_motion=[]; %contains all the different trials of a specific motion
indices = [];
counter = 0;

for k = 1:length(executionDirs) %execution of a specific motion, e.g. Shaker -> Gewoon1
    if(find(ismember(executionType,executionDirs(k).name))) %consider only the specified execution types
        data = dir([directory '/' motionDir '/' executionDirs(k).name]);
        data  = data(arrayfun(@(x) ~strcmp(x.name(1),'.'),data));
        
        % sort_nat sorts strings containing digits in a way such that the numerical value of the digits is taken into account e.g. invariants_1 < invariants_10 instead of invariants_10 > invariants_1
        [~,order] = sort_nat({data.name});
        data = data(order);
        
        indices = [indices trainingdata_indices.(executionDirs(k).name)+counter];
        counter = counter + length(data);
        
        for l = 1:length(data) %specific data file e.g. Shaker -> Gewoon1 -> trial1.mat
            location =[directory '/' motionDir '/' executionDirs(k).name '/' data(l).name];
            A = load(location);
            
            % Load data according to the given type of invariants
            % Interpolation is needed in order to give each trial the same length
            
            descriptor = A.descriptor.Descriptor;
            m = size(descriptor,1);
            descriptor_interp = interp1(1:m,descriptor,linspace(1,m,nb_samples));
            invariants_trials_motion = [invariants_trials_motion descriptor_interp];
        end
    end
end

[N,M] = size(invariants_trials_motion);
width_band = round(params.width_band*N); % compute width of the band used in the DTW algorithm
MODEL.trainingData = trainingdata_indices;
MODEL.modelsParameters = params;
choiceInvariants = params.choiceInvariants.(typeInvariant);

% Names of the individual invariants that were calculated: e.g. O1, V2, ...
invariant_names = fieldnames(choiceInvariants);
for i=1:size(invariant_names)
    invariant_name = invariant_names{i};
    if (choiceInvariants.(invariant_name)==1) % check if we want to construct the model of a certain invariant
        display(['Building model of invariant ' invariant_name]);
        
        invariant_trials_motion = invariants_trials_motion(:,i:6:M); % retrieve the chosen invariant for all motions e.g. O1
        % @Maxim TODO does this happen? yes, outside of gewoon1
        invariant_trials_motion(isnan(invariant_trials_motion) == 1) = 0;
        
        model_invariant = construct_model_of_invariant(invariant_trials_motion,indices,width_band,params.use_weights);
        
        % calculate how well the trials correspond to the calculated model
        [discrimination, sigma] = calculate_discrimination_model(model_invariant,invariant_trials_motion,width_band);
        
        MODEL.(invariant_name) = struct('model',model_invariant,'discrimination',discrimination,'sigma',sigma);
    else
        MODEL.(invariant_name) = 0;
    end
end